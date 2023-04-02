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
    let addReviewButton = UIButton(type: .system)
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
        configureAddReviewButton()
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

    private func configureAddReviewButton() {
        contentView.addSubview(addReviewButton)

        let font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        let config = getConfiguration(font: font, title: "НАПИСАТЬ ОТЗЫВ")
        addReviewButton.configuration = config
        addReviewButton.backgroundColor = .white
        addReviewButton.layer.borderColor = UIColor.grayColor.cgColor
        addReviewButton.layer.borderWidth = 1.0
        addReviewButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addReviewButton.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: ProductConstants.sideIndent),
            addReviewButton.rightAnchor.constraint(
                lessThanOrEqualTo: contentView.rightAnchor,
                constant: -ProductConstants.sideIndent)
        ])
    }

    private func configureReviewsButton() {
        contentView.addSubview(showReviewsButton)
        let font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        let config = getConfiguration(font: font, title: "СМОТРЕТЬ ВСЕ ОТЗЫВЫ", imageName: "chevron.forward")
        showReviewsButton.configuration = config
        showReviewsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showReviewsButton.topAnchor.constraint(
                equalTo: addReviewButton.bottomAnchor,
                constant: ProductConstants.sideIndent),
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

    private func getConfiguration(font: UIFont, title: String, imageName: String = "") -> UIButton.Configuration {
        var container = AttributeContainer()
        container.font = font
        container.foregroundColor = .black

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(title, attributes: container)

        var sideInset: CGFloat = 10.0
        let topInset = ReviewsConstants.starsSpacing

        if !imageName.isEmpty {
            configuration.image = .init(systemName: imageName)
            configuration.imagePlacement = .trailing
            sideInset = 0
        }

        configuration.background.backgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.contentInsets = .init(top: topInset, leading: sideInset, bottom: topInset, trailing: sideInset)

        return configuration
    }
}
