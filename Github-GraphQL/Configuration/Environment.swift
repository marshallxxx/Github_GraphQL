//
//  Environment.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

protocol Environment {
    var githubGraphQLUrl: URL { get }
    var githubPersonalAccessToken: String { get }
}

struct DefaultEnvironment: Environment {
    var githubGraphQLUrl: URL { return URL(string: "https://api.github.com/graphql")! }
    var githubPersonalAccessToken: String { return "<YourToken>" }
}
