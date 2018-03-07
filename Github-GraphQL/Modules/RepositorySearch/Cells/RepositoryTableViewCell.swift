//
//  RepositoryTableViewCell.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 06/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

protocol RepositoryTableViewCellDelegate: class {
    func starRepositoory(with id: String)
    func unstarRepositoory(with id: String)
}

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var repoLikesButton: UIButton!

    private var repositoryId: String?
    private var repositoryStarred: Bool = false

    weak var delegate: RepositoryTableViewCellDelegate?

    func configure(with repository: Repository) {
        repositoryId = repository.id
        repositoryStarred = repository.isStarredByUser
        repoNameLabel.text = repository.name
        authorNameLabel.text = repository.owner ?? ""
        repoDescription.text = repository.description ?? ""
        languageNameLabel.text = repository.primaryLanguage ?? ""
        repoLikesButton.setTitle(String(repository.numberOfStars), for: .normal)
        repoLikesButton.tintColor = repositoryStarred ? UIColor.red : UIColor.darkGray
    }

    @IBAction func starButtonPressed(_ sender: Any) {
        guard let id = repositoryId else { return }
        if repositoryStarred {
            delegate?.unstarRepositoory(with: id)
        } else {
            delegate?.starRepositoory(with: id)
        }
    }

}
