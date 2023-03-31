//
//  ProductCell.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import UIKit

final class ProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let cellIdentifier = "ProductCell"

    var basketButtonAction: ((Any) -> Void)? {
        didSet {
            if basketButtonAction == nil {
                addToBasketButton.removeTarget(self, action: #selector(basketButtonDidTap), for: .touchUpInside)
            }
        }
    }
    var favoriteButtonAction: ((Any) -> Void)? {
        didSet {
            if favoriteButtonAction == nil {
                addToFavoriteButton.removeTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
            }
        }
    }

    // MARK: - Private properties

    private var productImage = UIImageView()
    private var categoryLabel = UILabel()
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    private var addToBasketButton = UIButton()
    private var addToFavoriteButton = UIButton()
    private var leftCellConstraints: [NSLayoutConstraint]?
    private var rightCellConstraints: [NSLayoutConstraint]?

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        rightCellConstraints?.forEach({ $0.isActive = false })
        leftCellConstraints?.forEach({ $0.isActive = false })
        basketButtonAction = nil
        favoriteButtonAction = nil
        productImage.image = nil
        categoryLabel.text = nil
        nameLabel.text = nil
        priceLabel.text = nil
        addToFavoriteButton.tintColor = .systemGray2
        addToFavoriteButton.setImage(.init(systemName: "heart"), for: .normal)
    }

    // MARK: - Functions

    func setupLeftCellConstraints() {
        rightCellConstraints?.forEach({ $0.isActive = false })
        leftCellConstraints?.forEach({ $0.isActive = true })
    }

    func setupRightCellConstraints() {
        leftCellConstraints?.forEach({ $0.isActive = false })
        rightCellConstraints?.forEach({ $0.isActive = true })
    }

    func setupData(_ cellModel: ProductCellModel) {
        categoryLabel.text = cellModel.category
        nameLabel.text = cellModel.name
        priceLabel.text = cellModel.price
    }

    func setupImage(_ image: UIImage?) {
        productImage.image = image
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        setupBaseCellConstraints()
        configureImageView()
        configureFavoriteButton()
        configureBasketButton()
        configureCategoryLabel()
        configureNameLabel()
        configurePriceLabel()
    }

    private func setupBaseCellConstraints() {
        leftCellConstraints = [
            categoryLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: CatalogConstants.cellTextIndent),
            categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ]

        rightCellConstraints = [
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            categoryLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -CatalogConstants.cellTextIndent),
        ]
    }

    private func configureImageView() {
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        productImage.image = UIImage(systemName: "brain.head.profile")
        productImage.backgroundColor = .systemGray6
        contentView.addSubview(productImage)

        setupConstraints(from: productImage, to: contentView)

        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.heightAnchor.constraint(
                equalTo: productImage.widthAnchor,
                multiplier: CatalogConstants.cellImageMultiplier)
        ])
    }

    private func configureFavoriteButton() {
        addToFavoriteButton.backgroundColor = .clear
        addToFavoriteButton.tintColor = .systemGray2
        addToFavoriteButton.setImage(.init(systemName: "heart"), for: .normal)
        addToFavoriteButton.contentVerticalAlignment = .center
        addToFavoriteButton.contentHorizontalAlignment = .center
        addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToFavoriteButton)
        addToFavoriteButton.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addToFavoriteButton.topAnchor.constraint(equalTo: productImage.topAnchor),
            addToFavoriteButton.rightAnchor.constraint(equalTo: productImage.rightAnchor),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: CatalogConstants.favoriteButtonSize),
            addToFavoriteButton.widthAnchor.constraint(equalTo: addToFavoriteButton.heightAnchor)
        ])
    }

    private func configureBasketButton() {
        addToBasketButton.backgroundColor = .black
        addToBasketButton.tintColor = .white
        addToBasketButton.setImage(.init(systemName: "basket"), for: .normal)
        addToBasketButton.contentVerticalAlignment = .center
        addToBasketButton.contentHorizontalAlignment = .center
        addToBasketButton.layer.borderWidth = 1
        addToBasketButton.layer.borderColor = UIColor.black.cgColor
        addToBasketButton.layer.cornerRadius = CatalogConstants.basketButtonSize / 2
        addToBasketButton.layer.masksToBounds = true
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToBasketButton)
        addToBasketButton.addTarget(self, action: #selector(basketButtonDidTap), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addToBasketButton.centerYAnchor.constraint(equalTo: productImage.bottomAnchor),
            addToBasketButton.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -CatalogConstants.cellSubviewsIndent),
            addToBasketButton.heightAnchor.constraint(equalToConstant: CatalogConstants.basketButtonSize),
            addToBasketButton.widthAnchor.constraint(equalTo: addToBasketButton.heightAnchor)
        ])
    }

    private func configureCategoryLabel() {
        categoryLabel.backgroundColor = .white
        categoryLabel.textColor = .label
        categoryLabel.numberOfLines = 2
        categoryLabel.lineBreakMode = .byTruncatingTail
        categoryLabel.font = .systemFont(ofSize: 9.0, weight: .medium)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(
                equalTo: addToBasketButton.bottomAnchor,
                constant: CatalogConstants.cellSubviewsIndent)
        ])
    }

    private func configureNameLabel() {
        nameLabel.backgroundColor = .white
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 3
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        setupConstraints(from: nameLabel, to: categoryLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: categoryLabel.bottomAnchor,
                constant: CatalogConstants.cellSubviewsIndent)
        ])
    }

    private func configurePriceLabel() {
        priceLabel.backgroundColor = .white
        priceLabel.textColor = .label
        priceLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        setupConstraints(from: priceLabel, to: categoryLabel)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: CatalogConstants.cellSubviewsIndent),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    private func setupConstraints(from: UIView, to: UIView) {
        NSLayoutConstraint.activate([
            from.leftAnchor.constraint(equalTo: to.leftAnchor),
            from.rightAnchor.constraint(equalTo: to.rightAnchor)
        ])
    }

    @objc private func basketButtonDidTap(_ sender: Any) {
        basketButtonAction?(sender)
    }

    @objc private func favoriteButtonDidTap(_ sender: Any) {
        favoriteButtonAction?(sender)
    }
}
