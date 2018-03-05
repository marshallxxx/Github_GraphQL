//
//  AppDelegate.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var services: ServiceContainer!
    var rootCoordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let environment = DefaultEnvironment()
        services = DefaultServiceContainer(environment: environment)
        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        rootCoordinator = RepoCoordinator(services: services,
                                          navigationController: navigationController)
        rootCoordinator.start()

        window?.makeKeyAndVisible()

        return true
    }

}

