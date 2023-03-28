//
//  ReviewsView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ReviewsView: UIView {

    // MARK: - Properties

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewsViewCell.self, forCellReuseIdentifier: ReviewsViewCell.cellIdentifier)

        return tableView
    }()

    let showAllReviewsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .regular)
        button.titleLabel?.text = "СМОТРЕТЬ ВСЕ ОТЗЫВЫ"
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
    }

    // MARK: - Private functions

    private func configureComponents() {
        backgroundColor = .white

        configureTableView()
        configureButtonView()
    }

    private func configureTableView() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func configureButtonView() {
        addSubview(showAllReviewsButton)

        NSLayoutConstraint.activate([
            showAllReviewsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: ReviewsConstants.sideIndent),
            showAllReviewsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -ReviewsConstants.sideIndent),
            showAllReviewsButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ReviewsConstants.interitemSpacing),
            showAllReviewsButton.topAnchor.constraint(
                equalTo: tableView.bottomAnchor,
                constant: ReviewsConstants.interitemSpacing)
        ])
    }
}
