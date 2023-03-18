//
//  InitialView.swift
//  GBShop
//
//  Created by Artem Mayer on 17.03.2023.
//

import UIKit

final class InitialView: UIView {

    // MARK: - Properties

    let logoImage = UIImageView()
    let loadingSpinner = UIActivityIndicatorView(style: .large)
    let imageSize: CGFloat = 64.0

    // MARK: - Constructions

    required init() {
        super.init(frame: .zero)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        backgroundColor = .systemBackground
        addSubview(logoImage)
        addSubview(loadingSpinner)

        configureLogo()
        configureSpinner()
    }

    private func configureLogo() {
        logoImage.backgroundColor = .systemBackground
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: imageSize),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func configureSpinner() {
        loadingSpinner.color = .label
        loadingSpinner.tintColor = .label
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingSpinner.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: LayoutConstants.topIndent),
            loadingSpinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

}
