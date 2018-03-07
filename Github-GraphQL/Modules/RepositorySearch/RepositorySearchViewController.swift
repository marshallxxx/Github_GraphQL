//
//  RepositorySearchViewController.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositorySearchViewController: UITableViewController,
RepositoryTableViewCellDelegate {

    private let cellIdentifier = String(describing: RepositoryTableViewCell.self)
    private lazy var searhcController = UISearchController.make()
    var presenter: RepositorySearchPresenterType!
    private var repositories: [Repository] = []
    private var disposeBag = DisposeBag()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "repositories".localized()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searhcController
        navigationItem.hidesSearchBarWhenScrolling = false

        registerToSearchTermChange()
    }

    private func registerToSearchTermChange() {
        searhcController.searchBar.rx.text.asDriver()
            .distinctUntilChanged { $0 == $1 }
            .throttle(0.3)
            .flatMap({ [weak self] (term) -> Driver<[Repository]> in
                guard let `self` = self,
                    let searchTerm = term else { return .just([]) }
                return self.presenter.searchRepositories(with: searchTerm)
                    .asDriver(onErrorJustReturn: [])
            })
            .drive(onNext: { [weak self] (repositories) in
                self?.repositories = repositories
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - RepositoryTableViewCellDelegate

    func starRepositoory(with id: String) {
        presenter.starRepository(with: id)
            .subscribe(onSuccess: { [weak self] (numberOfStars) in
                if let `self` = self,
                    var repository = self.findRepository(with: id) {
                    repository.numberOfStars = numberOfStars
                    repository.isStarredByUser = true
                    self.replaceRepository(with: repository)
                }
            })
            .disposed(by: disposeBag)
    }

    func unstarRepositoory(with id: String) {
        presenter.unstarRepository(with: id)
            .subscribe(onSuccess: { [weak self] (numberOfStars) in
                if let `self` = self,
                    var repository = self.findRepository(with: id) {
                    repository.numberOfStars = numberOfStars
                    repository.isStarredByUser = false
                    self.replaceRepository(with: repository)
                }
            })
            .disposed(by: disposeBag)
    }

    private func findRepository(with id: String) -> Repository? {
        return repositories.first(where: { (repo) -> Bool in
            return repo.id == id
        })
    }

    private func replaceRepository(with repository: Repository) {
        if let index = repositories.index(of: repository) {
            repositories.remove(at: index)
            repositories.insert(repository, at: index)
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: repositories[indexPath.row])
        cell.delegate = self
        return cell
    }

}

private extension UISearchController {
    static func make() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }
}
