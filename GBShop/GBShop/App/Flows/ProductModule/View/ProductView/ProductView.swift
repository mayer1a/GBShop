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
    let showReviewsButton = UIButton()

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
        configureReviewsButton()
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

    private func configureReviewsButton() {
        contentView.addSubview(showReviewsButton)

        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 20.0, weight: .semibold)
        container.foregroundColor = .black

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("СМОТРЕТЬ ВСЕ ОТЗЫВЫ", attributes: container)
        configuration.image = .init(systemName: "chevron.forward")
        configuration.imagePlacement = .trailing
        configuration.background.backgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.titleAlignment = .trailing
        configuration.contentInsets = .init(
            top: ReviewsConstants.starsSpacing,
            leading: 0,
            bottom: ReviewsConstants.starsSpacing,
            trailing: 0)

        showReviewsButton.configuration = configuration
        showReviewsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showReviewsButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -ProductConstants.largeIndent),
            showReviewsButton.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: ProductConstants.sideIndent),
            showReviewsButton.rightAnchor.constraint(
                lessThanOrEqualTo: contentView.rightAnchor,
                constant: -ProductConstants.sideIndent)
        ])
    }
}
