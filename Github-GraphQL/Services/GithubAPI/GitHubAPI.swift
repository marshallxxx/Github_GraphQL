//
//  GitHubAPI.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 06/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubAPI {
    func fetchRepositoriesByName(name: String) -> Single<[Repository]>
}
