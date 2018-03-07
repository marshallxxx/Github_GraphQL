//
//  RepositorySearchPresenter.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositorySearchPresenterType {
    func searchRepositories(with name: String) -> Single<[Repository]>
    func starRepository(with identifier: String) -> Single<Int>
    func unstarRepository(with identifier: String) -> Single<Int>
}

class RepositorySearchPresenter: RepositorySearchPresenterType {
    private unowned var coordinator: RepositorySearchCoordinatorType
    private var githubApi: GitHubAPI

    init(coordinator: RepositorySearchCoordinatorType,
         githubApi: GitHubAPI) {
        self.coordinator = coordinator
        self.githubApi = githubApi
    }

    func searchRepositories(with name: String) -> Single<[Repository]> {
        return githubApi.fetchRepositoriesByName(name: name)
    }

    func starRepository(with identifier: String) -> Single<Int> {
        return githubApi.starRepository(repositoryId: identifier)
    }

    func unstarRepository(with identifier: String) -> Single<Int> {
        return githubApi.unstarRepository(repositoryId: identifier)
    }

}
