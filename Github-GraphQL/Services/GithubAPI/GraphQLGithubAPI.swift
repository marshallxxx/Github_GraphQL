//
//  GraphQLGithubAPI.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 06/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import RxSwift
import Apollo

enum GraphQLGithubAPIError: Error {
    case fetchError(Error)
    case noQueryResult
    case errorsInQueryResult([Error])
    case noQueryResultData
    case taskCancelled
    case unauthorized
}

class GraphQLGithubAPI: GitHubAPI {

    private let responsesPerPage: Int = 20

    private var apolloClient: ApolloClient

    init(graphQLUrl: URL,
         authorization: String) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "bearer \(authorization)"]
        self.apolloClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: graphQLUrl, configuration: configuration))
    }

    /// Fetches repositories by name
    func fetchRepositoriesByName(name: String) -> Single<[Repository]> {
        return Single.create(subscribe: { [weak self] (single) -> Disposable in
            guard let `self` = self else {
                single(.error(GraphQLGithubAPIError.taskCancelled))
                return Disposables.create()
            }

            // Perform GraphQL query
            let query = RepositoryByNameFetchQuery(repoName: name, numberOfItems: self.responsesPerPage)
            let task = self.apolloClient.fetch(query: query) { result, error in
                // Sanitize GraphQL result
                if let error = self.sanitizeQueryResponse(result: result, error: error) {
                    single(.error(error))
                    return
                }

                // Map to model
                let repositories = result!.data!.search.edges?.flatMap({ edge in
                    return edge?.node?.asRepository
                }).map({ (repository) -> Repository in
                    let owner = repository.owner.asUser?.name ?? repository.owner.asOrganization?.name
                    return Repository(id: repository.id,
                                      name: repository.name,
                                      description: repository.description,
                                      numberOfStars: repository.stargazers.totalCount,
                                      primaryLanguage: repository.languages!.nodes?.first??.name,
                                      owner: owner,
                                      isStarredByUser: repository.viewerHasStarred)
                })
                
                single(.success(repositories ?? []))
            }

            return Disposables.create {
                task.cancel()
            }
        })
    }

    /// Stars repository
    func starRepository(repositoryId: String) -> Single<Int> {
        return Single.create { [weak self] (single) -> Disposable in
            guard let `self` = self else {
                single(.error(GraphQLGithubAPIError.taskCancelled))
                return Disposables.create()
            }

            let mutation = StarRepositoryMutation(repositoryID: repositoryId)
            let task = self.apolloClient.perform(mutation: mutation) { result, error in
                // Sanitize GraphQL result
                if let error = self.sanitizeQueryResponse(result: result, error: error) {
                    single(.error(error))
                    return
                }

                // Parse response
                let numberOfStars = result!.data!.addStar?.starrable.stargazers.totalCount
                single(.success(numberOfStars ?? 0))
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }

    /// Unstar repository
    func unstarRepository(repositoryId: String) -> Single<Int> {
        return Single.create { [weak self] (single) -> Disposable in
            guard let `self` = self else {
                single(.error(GraphQLGithubAPIError.taskCancelled))
                return Disposables.create()
            }

            let mutation = UnstarRepositoryMutation(repositoryID: repositoryId)
            let task = self.apolloClient.perform(mutation: mutation) { result, error in
                // Sanitize GraphQL result
                if let error = self.sanitizeQueryResponse(result: result, error: error) {
                    single(.error(error))
                    return
                }

                // Parse response
                let numberOfStars = result!.data!.removeStar?.starrable.stargazers.totalCount
                single(.success(numberOfStars ?? 0))
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }

    // MARK: - Helpers

    private func sanitizeQueryResponse<ResultType>(result: GraphQLResult<ResultType>?, error: Error?) -> Error? {

        if let error = error as? Apollo.GraphQLHTTPResponseError,
            error.response.statusCode == 401 {
            debugPrint("Unauthorized request: \(error.localizedDescription)")
            return GraphQLGithubAPIError.unauthorized
        }

        if let error = error {
            debugPrint("Error while fetching query: \(error.localizedDescription)")
            return GraphQLGithubAPIError.fetchError(error)
        }

        guard let result = result else {
            debugPrint("No query result")
            return GraphQLGithubAPIError.noQueryResult
        }

        if let errors = result.errors {
            debugPrint("Errors in query result: \(errors)")
            return GraphQLGithubAPIError.errorsInQueryResult(errors)
        }

        guard let _ = result.data else {
            debugPrint("No query result data")
            return GraphQLGithubAPIError.noQueryResultData
        }

        return nil
    }

}
