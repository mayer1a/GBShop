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

    private var presenter: ReviewsPresenterProtocol!
    private var reviewsIsLoading: Bool = false
    private var reviews: [ReviewCellModel] = [] {
        didSet {
            reviewsView?.tableView.reloadData()
            setDynamicHeight()
        }
    }

    private var tableViewHeight: NSLayoutConstraint?
    private var isSubmodule: Bool = false

    // MARK: - Lifecycle

    override func loadView() {
        view = ReviewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewsView?.titleLabel.isHidden = true
        setupTargets()
        setupConstraint()
        setupAddReviewButton()
        presenter.onViewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setDynamicHeight()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: ReviewsPresenterProtocol) {
        self.presenter = presenter
    }

    func setupAsSubmodule() {
        isSubmodule = true
    }

    // MARK: - Private functions

    private func setupTargets() {
        reviewsView?.tableView.delegate = self
        reviewsView?.tableView.dataSource = self
    }

    private func setupConstraint() {
        guard let reviewsView, isSubmodule else { return }

        tableViewHeight = NSLayoutConstraint(
            item: reviewsView.tableView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 100.0)

        tableViewHeight?.isActive = true
        reviewsView.titleLabel.isHidden = false
    }

    private func setDynamicHeight() {
        if isSubmodule {
            updateConstraint()
        }
    }

    private func updateConstraint() {
        guard let reviewsView else { return }

        reviewsView.tableView.invalidateIntrinsicContentSize()
        reviewsView.tableView.layoutIfNeeded()

        tableViewHeight?.constant = reviewsView.tableView.contentSize.height
    }

    @objc private func addReviewButtonDidTap(_ sender: UIButton) {
        presenter.addReviewButtonDidTap()
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
                !self.reviewsIsLoading,
                let maxRowToEnd = indexPaths.map({ $0.item }).max(),
                maxRowToEnd > self.reviews.count - 6
            else {
                return
            }

            self.reviewsIsLoading = true
            self.presenter.scrollWillEnd()
        }
    }

}

// MARK: - ReviewsViewProtocol

extension ReviewsViewController: ReviewsViewProtocol {

    // MARK: - Functions
    
    func showFailure(with message: String?) {
        // TODO: warning label will shown when label is ready
    }

    func removeWarning() {
        // TODO: warning label will hidden when label is ready
    }

    func reviewsDidFetch(_ reviews: [ReviewCellModel]) {
        self.reviews = reviews
        self.reviewsIsLoading = false
    }

    func setupAddReviewButton() {
        let reviewButton = UIBarButtonItem()
        reviewButton.title = "написать отзыв"
        reviewButton.target = self
        reviewButton.style = .plain
        reviewButton.action = #selector(addReviewButtonDidTap)

        navigationItem.rightBarButtonItem = reviewButton
    }
}
