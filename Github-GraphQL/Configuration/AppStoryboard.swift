//
//  Storyboards.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case main = "Main"

    func reference() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
}
