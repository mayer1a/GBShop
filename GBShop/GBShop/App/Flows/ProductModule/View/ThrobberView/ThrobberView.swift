//
//  ThrobberView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ThrobberView: UIView {

    // MARK: - Properties

    let throbber = UIActivityIndicatorView(style: .large)

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
        addSubview(throbber)

        configureThrobber()
    }

    private func configureThrobber() {
        throbber.color = .black
        throbber.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            throbber.leftAnchor.constraint(equalTo: leftAnchor, constant: ProductConstants.throbberIndent),
            throbber.rightAnchor.constraint(equalTo: rightAnchor, constant: -ProductConstants.throbberIndent),
            throbber.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            throbber.heightAnchor.constraint(equalTo: throbber.widthAnchor)
        ])
    }
}
