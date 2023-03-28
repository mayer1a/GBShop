//
//  ReviewsViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ReviewsViewController: UIViewController {

    // MARK: - Properties


    var reviewsView: ReviewsView? {
        isViewLoaded ? view as? ReviewsView : nil
    }

    // MARK: - Private properties

//    private var presenter: ReviewsPresenterProtocol!
//    private var reviewsIsLoading: Bool = false
    private var reviews: [ReviewCellModel] = [] {
        didSet {
            reviewsView?.tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ReviewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTargets()
//        presenter.onViewDidLoad()
        reviewsView?.tableView.delegate = self
        reviewsView?.tableView.dataSource = self
    }

    // MARK: - Functions

//    func setPresenter(_ presenter: ReviewsPresenterProtocol) {
//        self.presenter = presenter
//    }

    func setupData(_ reviews: [ReviewCellModel]) {
        self.reviews = reviews
    }

    // MARK: - Private functions

    private func setupTargets() {
        reviewsView?.tableView.delegate = self
        reviewsView?.tableView.dataSource = self
        reviewsView?.showAllReviewsButton.addTarget(self, action: #selector(showAllButtonDidTap), for: .touchUpInside)
    }

    @objc private func showAllButtonDidTap() {
//        presenter.showAllButtonDidTap()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsViewCell.cellIdentifier, for: indexPath)

        guard let cell = cell as? ReviewsViewCell else { return UITableViewCell() }

        cell.setupData(reviews[indexPath.row])

        return cell
    }

}

// MARK: - UITableViewDataSourcePrefetching

extension ReviewsViewController: UITableViewDataSourcePrefetching {

    // MARK: - Functions

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        DispatchQueue.global().async { [weak self] in
            guard
                let self,
                let maxRowToEnd = indexPaths.map({ $0.item }).max(),
                maxRowToEnd > self.reviews.count - 6
            else {
                return
            }

//            self.presenter.scrollWillEnd()
        }
    }

}
