//
//  RepoPresenter.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

protocol RepoPresenterType {

}

class RepoPresenter: RepoPresenterType {
    unowned var view: RepoView
    unowned var coordinator: RepoCoordinatorType
    
    init(view: RepoView, coordinator: RepoCoordinatorType) {
        self.view = view
        self.coordinator = coordinator
    }

}
