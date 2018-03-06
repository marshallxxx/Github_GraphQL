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
    case fetchTaskCancelled
    case unauthorized
}

class GraphQLGithubAPI: GitHubAPI {

    private var apolloClient: ApolloClient

    init(graphQLUrl: URL,
         authorization: String) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "bearer \(authorization)"]
        self.apolloClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: graphQLUrl, configuration: configuration))
    }

    func fetchRepositoriesByName(name: String) -> Single<[Repository]> {
        return Single.create { [weak self] (single) -> Disposable in
            guard let `self` = self else {
                single(.error(GraphQLGithubAPIError.fetchTaskCancelled))
                return Disposables.create()
            }

            // Perform GraphQL query
            let task = self.apolloClient.fetch(query: RepositoryByNameQuery(repoName: name)) { result, error in
                // Sanitize GraphQL result
                if let error = self.sanitizeQueryResponse(result: result, error: error) {
                    single(.error(error))
                    return
                }

                // Map to model
                let repositories = result!.data!.search.edges?.flatMap({ edge in
                    return edge?.node?.asRepository
                }).map({ (repository) -> Repository in
                    return Repository(name: repository.name,
                                      description: repository.description,
                                      numberOfStars: repository.stargazers.totalCount,
                                      primaryLanguage: repository.languages!.nodes?.first??.name)
                })
                
                single(.success(repositories ?? []))
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
