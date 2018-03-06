//
//  RepoPresenter.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import RxSwift

protocol RepoPresenterType {
    func searchRepositories(with name: String) -> Single<[Repository]>
}

class RepoPresenter: RepoPresenterType {
    private unowned var coordinator: RepoCoordinatorType
    private var githubApi: GitHubAPI

    init(coordinator: RepoCoordinatorType,
         githubApi: GitHubAPI) {
        self.coordinator = coordinator
        self.githubApi = githubApi
    }

    func searchRepositories(with name: String) -> Single<[Repository]> {
        return githubApi.fetchRepositoriesByName(name: name)
    }

}
