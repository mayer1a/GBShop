//
//  DescriptionView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class DescriptionView: UIView {

    // MARK: - Properties

    let priceLabel = UILabel()
    let descriptionLabel = UILabel()

    // MARK: - Private properties

    private let placeLabel = UILabel()

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
        addSubview(priceLabel)
        addSubview(placeLabel)
        addSubview(descriptionLabel)

        configurePriceLabel()
        configurePlaceLabel()
        configureDescriptionLabel()
    }

    private func configurePriceLabel() {
        priceLabel.backgroundColor = backgroundColor
        priceLabel.textColor = .black
        priceLabel.numberOfLines = 1
        priceLabel.lineBreakMode = .byTruncatingTail
        priceLabel.font = .systemFont(ofSize: 24.0, weight: .medium)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints(from: priceLabel, to: topAnchor, constant: ProductConstants.sideIndent)
    }

    private func configurePlaceLabel() {
        placeLabel.backgroundColor = backgroundColor
        placeLabel.textColor = .black
        placeLabel.numberOfLines = 1
        placeLabel.lineBreakMode = .byWordWrapping
        placeLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        placeLabel.text = "ОПИСАНИЕ"
        placeLabel.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints(from: placeLabel, to: priceLabel.bottomAnchor, constant: ProductConstants.sideIndent)
    }

    private func configureDescriptionLabel() {
        descriptionLabel.backgroundColor = backgroundColor
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints(from: descriptionLabel, to: placeLabel.bottomAnchor, constant: ProductConstants.sideIndent)

        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -ProductConstants.interitemSpacing)
        ])
    }

    private func setupConstraints(from: UIView, to: NSLayoutYAxisAnchor, constant: CGFloat) {
        NSLayoutConstraint.activate([
            from.topAnchor.constraint(equalTo: to, constant: constant),
            from.leftAnchor.constraint(equalTo: leftAnchor, constant: ProductConstants.sideIndent),
            from.rightAnchor.constraint(equalTo: rightAnchor, constant: -ProductConstants.sideIndent)
        ])
    }
}
