//
//  ProductView.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ProductView: UIView {

    // MARK: - Properties

    let mainView = UIView()
    let scrollView = UIScrollView()
    let contentView = UIView()

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
        addSubview(mainView)

        configureMainView()
        configureScrollView()
        configureInitialView()
    }

    private func configureMainView() {
        mainView.addSubview(scrollView)
        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leftAnchor.constraint(equalTo: leftAnchor),
            mainView.rightAnchor.constraint(equalTo: rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: mainView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: mainView.rightAnchor)
        ])
    }

    private func configureInitialView() {
        contentView.backgroundColor = backgroundColor
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),

            contentView.leftAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.rightAnchor)
        ])
    }
}
