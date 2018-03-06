//
//  RepoViewController.swift
//  Github-GraphQL
//
//  Created by Evghenii Nicolaev on 05/03/2018.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoViewController: UITableViewController {

    private let cellIdentifier = String(describing: RepoTableViewCell.self)
    private lazy var searhcController = UISearchController.make()
    var presenter: RepoPresenterType!
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

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! RepoTableViewCell
        cell.configure(with: repositories[indexPath.row])
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
