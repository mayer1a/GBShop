//
//  BasketHeaderView.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

final class BasketHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties

    static let reuseIdentifier = "BasketHeaderView"

    // MARK: - Private properties

    private let titleLabel = UILabel()
    private let quantityLabel = UILabel()

    // MARK: - Constructions

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewComponents()
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        setupEmpty()
    }

    // MARK: - Functions

    func setupQuantity(_ value: Int) {
        quantityLabel.text = " / \(value)"
    }

    func setupEmpty() {
        quantityLabel.text = nil
        titleLabel.text = "в вашей корзине пока ничего нет ..."
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        backgroundColor = .white
        contentView.backgroundColor = .white

        setupEmpty()
        configureTitleLabel()
        configureQuantityLabel()
    }

    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        configureLabel(label: titleLabel, font: .systemFont(ofSize: 20.0, weight: .bold))

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ProductConstants.sideIndent),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ProductConstants.sideIndent),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ProductConstants.sideIndent)
        ])
    }

    private func configureQuantityLabel() {
        contentView.addSubview(quantityLabel)
        configureLabel(label: quantityLabel, font: .systemFont(ofSize: 16.0, weight: .semibold))

        NSLayoutConstraint.activate([
            quantityLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor),
            quantityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ProductConstants.sideIndent),
            quantityLabel.rightAnchor.constraint(
                lessThanOrEqualTo: contentView.rightAnchor,
                constant: -ProductConstants.sideIndent),
            quantityLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -ProductConstants.sideIndent)
        ])
    }

    private func configureLabel(label: UILabel, font: UIFont) {
        titleLabel.font = font
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
