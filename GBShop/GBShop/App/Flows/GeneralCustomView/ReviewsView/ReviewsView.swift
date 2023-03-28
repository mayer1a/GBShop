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
    }

    private func configureTableView() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
