//
//  Repository.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 06/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

struct Repository {
    var id: String
    var name: String
    var description: String?
    var numberOfStars: Int
    var primaryLanguage: String?
    var owner: String?
    var isStarredByUser: Bool
}

extension Repository: Hashable {
    var hashValue: Int { return id.hashValue }

    static func ==(lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}
