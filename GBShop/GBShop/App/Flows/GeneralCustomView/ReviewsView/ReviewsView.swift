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
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ReviewsViewCell.self, forCellReuseIdentifier: ReviewsViewCell.cellIdentifier)

        return tableView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        label.text = "ОТЗЫВЫ"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
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
        configureTitleLabel()
    }

    private func configureTableView() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ReviewsConstants.sideIndent),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: ReviewsConstants.sideIndent),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -ReviewsConstants.sideIndent),
            titleLabel.bottomAnchor.constraint(
                equalTo: tableView.topAnchor,
                constant: -ReviewsConstants.interitemSpacing)
        ])
    }

}
