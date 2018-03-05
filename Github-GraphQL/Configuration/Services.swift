//
//  Services.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

protocol ServiceContainer {
    
}

struct DefaultServiceContainer: ServiceContainer {

    private var environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }

}
