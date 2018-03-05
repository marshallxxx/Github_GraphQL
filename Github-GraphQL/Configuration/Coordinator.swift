//
//  Coordinator.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

protocol Coordinator: class {

    /// The services that the coordinator can use
    var services: ServiceContainer { get }

    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }

    /// Present module
    func start()

}

extension Coordinator {

    /// Add a child coordinator to the parent
    func addChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    /// Remove a child coordinator from the parent
    func removeChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }

}
