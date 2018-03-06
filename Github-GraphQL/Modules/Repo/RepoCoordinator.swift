//
//  RepoCoordinator.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

protocol RepoCoordinatorType: Coordinator {
    
}

class RepoCoordinator: RepoCoordinatorType {

    private(set) var services: ServiceContainer
    var childCoordinators: [Coordinator]

    private var navigationController: UINavigationController
    private let storyboard = AppStoryboard.main
    private let viewControllerIdentifier = String(describing: RepoViewController.self)

    init(services: ServiceContainer,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    private func buildViewController() -> UIViewController {
        let viewController = storyboard.reference()
            .instantiateViewController(withIdentifier: viewControllerIdentifier)
            as! RepoViewController
        let presenter = RepoPresenter(coordinator: self,
                                      githubApi: services.gitHubAPI)
        viewController.presenter = presenter
        return viewController
    }

    func start() {
        navigationController.viewControllers = [buildViewController()]
    }

}
