//
//  RepoTableViewCell.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 06/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var repoLikesButton: UIButton!

    func configure(with repository: Repository) {
        repoNameLabel.text = repository.name
        repoDescription.text = repository.description ?? ""
        languageNameLabel.text = repository.primaryLanguage ?? ""
        repoLikesButton.setTitle(String(repository.numberOfStars), for: .normal)
    }

}
