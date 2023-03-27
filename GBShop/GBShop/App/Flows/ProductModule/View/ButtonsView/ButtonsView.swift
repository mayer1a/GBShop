//
//  ButtonsView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ButtonsView: UIView {

    // MARK: - Properties

    let basketButton = UIButton()
    let favoriteButton = UIButton()

    // MARK: - Constructions

    required init() {
        super.init(frame: .zero)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewComponents()
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        backgroundColor = .white
        addSubview(basketButton)
        addSubview(favoriteButton)

        setupBasketButtonView()
        setupFavoriteButtonView()
    }

    private func setupBasketButtonView() {
        basketButton.setTitleColor(.white, for: .normal)
        basketButton.setTitleColor(.gray, for: .highlighted)
        basketButton.setTitle("ДОБАВИТЬ В КОРЗИНУ", for: .normal)
        setupButton(basketButton)

        NSLayoutConstraint.activate([
            basketButton.leftAnchor.constraint(equalTo: leftAnchor, constant: ProductConstants.sideIndent),
            basketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ProductConstants.interitemSpacing),
            basketButton.topAnchor.constraint(equalTo: topAnchor, constant: ProductConstants.interitemSpacing),
            basketButton.heightAnchor.constraint(equalToConstant: ProductConstants.buttonsHeight),
            basketButton.rightAnchor.constraint(
                equalTo: favoriteButton.leftAnchor,
                constant: -ProductConstants.interitemSpacing)
        ])
    }

    private func setupFavoriteButtonView() {
        favoriteButton.setImage(.init(systemName: "heart"), for: .normal)
        setupButton(favoriteButton)

        NSLayoutConstraint.activate([
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -ProductConstants.sideIndent),
            favoriteButton.bottomAnchor.constraint(equalTo: basketButton.bottomAnchor),
            favoriteButton.topAnchor.constraint(equalTo: basketButton.topAnchor),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }

    private func setupButton(_ button: UIButton) {
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
}
