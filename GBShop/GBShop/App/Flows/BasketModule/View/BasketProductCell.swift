//
//  BasketProductCell.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

final class BasketProductCell: UITableViewCell {

    // MARK: - Properties

    static let cellIdentifier = "BasketProductCell"
    var quantityStepper = ChangeableStepper()

    // MARK: - Private properties

    private var productImageView = UIImageView()
    private var categoryLabel = UILabel()
    private var nameLabel = UILabel()
    private var amountLabel = UILabel()

    // MARK: - Constructions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewComponents()
    }


    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        categoryLabel.text = nil
        nameLabel.text = nil
        amountLabel.text = nil
        quantityStepper.stepperAction = nil
        quantityStepper.clearLabel()
    }

    // MARK: - Functions

    func setupData(_ cellModel: BasketCellModel) {
        categoryLabel.text = cellModel.category
        nameLabel.text = cellModel.name
        amountLabel.text = cellModel.price
        quantityStepper.setupValue(cellModel.quantity)
    }

    func setupImage(_ image: UIImage?) {
        productImageView.image = image
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        selectionStyle = .none

        configureImageView()
        configureCategoryLabel()
        configureNameLabel()
        configureAmountLabel()
        configureStepper()
    }

    private func configureImageView() {
        contentView.addSubview(productImageView)

        productImageView.backgroundColor = .lightGray
        productImageView.tintColor = .white
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: ProductConstants.sideIndent),
            productImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: ProductConstants.sideIndent),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor)
        ])
    }

    private func configureCategoryLabel() {
        contentView.addSubview(categoryLabel)

        setupLabel(categoryLabel, font: .systemFont(ofSize: 9.0, weight: .medium), textColor: .black, lines: 2)

        NSLayoutConstraint.activate([
            categoryLabel.leftAnchor.constraint(
                equalTo: productImageView.rightAnchor,
                constant: ProductConstants.sideIndent),
            categoryLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -ProductConstants.sideIndent),
            categoryLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: ProductConstants.sideIndent)
        ])
    }

    private func configureNameLabel() {
        contentView.addSubview(nameLabel)

        setupLabel(nameLabel, font: .systemFont(ofSize: 16.0, weight: .semibold), textColor: .gray, lines: 3)

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(
                equalTo: productImageView.rightAnchor, 
                constant: ProductConstants.sideIndent),
            nameLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor, 
                constant: -ProductConstants.sideIndent),
            nameLabel.topAnchor.constraint(
                equalTo: categoryLabel.bottomAnchor,
                constant: ProductConstants.sideIndent)
        ])
    }

    private func configureAmountLabel() {
        contentView.addSubview(amountLabel)
        
        setupLabel(nameLabel, font: .systemFont(ofSize: 16.0, weight: .semibold), textColor: .gray, lines: 1)

        NSLayoutConstraint.activate([
            amountLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: ProductConstants.sideIndent),
            amountLabel.topAnchor.constraint(
                equalTo: productImageView.bottomAnchor,
                constant: ProductConstants.sideIndent),
            amountLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -ProductConstants.largeIndent)
        ])
    }

    private func configureStepper() {
        contentView.addSubview(quantityStepper)
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            quantityStepper.leftAnchor.constraint(
                greaterThanOrEqualTo: amountLabel.rightAnchor,
                constant: ProductConstants.sideIndent),
            quantityStepper.topAnchor.constraint(equalTo: amountLabel.topAnchor),
            quantityStepper.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -ProductConstants.sideIndent),
            quantityStepper.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -ProductConstants.largeIndent)
        ])
    }

    private func setupLabel(_ label: UILabel, font: UIFont, textColor: UIColor, lines: Int) {
        label.font = font
        label.backgroundColor = .white
        label.textColor = textColor
        label.numberOfLines = lines
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
    }

}
