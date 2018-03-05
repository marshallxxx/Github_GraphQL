//
//  ModuleBuilder.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

struct ModuleBuilder {

    static let shared = ModuleBuilder()

    private var environment: Environment

    private init(environment: Environment = DefaultEnvironment()) {
        self.environment = environment
    }

    func buildRepoModule() -> UIViewController {
        let storyboard = AppStoryboard.main.reference()
        let identifier = String(describing: RepoViewController.self)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! RepoViewController
        let presenter = RepoPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController as UIViewController
    }

}
