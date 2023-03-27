//
//  HeaderView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class HeaderView: UIView {

    // MARK: - Properties

    let categoryLabel = UILabel()
    let nameLabel = UILabel()

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
        addSubview(categoryLabel)
        addSubview(nameLabel)

        configureCategoryLabel()
        configureNameLabel()
    }

    private func configureCategoryLabel() {
        categoryLabel.backgroundColor = backgroundColor
        categoryLabel.textColor = .black
        categoryLabel.numberOfLines = 2
        categoryLabel.lineBreakMode = .byTruncatingTail
        categoryLabel.font = .systemFont(ofSize: 9.0, weight: .medium)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: ProductConstants.interitemSpacing),
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: ProductConstants.sideIndent),
            categoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -ProductConstants.sideIndent)
        ])
    }

    private func configureNameLabel() {
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.font = .systemFont(ofSize: 20.0, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: ProductConstants.sideIndent),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -ProductConstants.sideIndent),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ProductConstants.interitemSpacing),
            nameLabel.topAnchor.constraint(
                equalTo: categoryLabel.bottomAnchor,
                constant: ProductConstants.interitemSpacing)
        ])
    }
}
