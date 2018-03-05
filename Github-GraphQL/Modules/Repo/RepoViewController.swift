//
//  RepoViewController.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

protocol RepoView: class where Self: UIViewController {

}

class RepoViewController: UIViewController, RepoView {

    var presenter: RepoPresenterType!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
