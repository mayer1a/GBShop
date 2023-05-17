//
//  BasketView.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

final class BasketView: UIView {

    // MARK: - Properties

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BasketProductCell.self, forCellReuseIdentifier: BasketProductCell.cellIdentifier)
        tableView.register(BasketHeaderView.self, forHeaderFooterViewReuseIdentifier: BasketHeaderView.reuseIdentifier)

        return tableView
    }()

    let placeOrderButton = UIButton()

    var isHiddenBottomView: Bool = true {
        didSet {
            bottomView.isHidden = isHiddenBottomView
        }
    }

    // MARK: - Private properties

    private let totalPriceTitleLabel = UILabel()
    private let totalPriceLabel = UILabel()
    private let bottomView = UIView()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewComponents()
    }

    // MARK: - Functions

    func setupPrice(_ value: String) {
        totalPriceLabel.text = value
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        backgroundColor = .white
        configureTableView()
        configureBottomView()
        setupPriceTitleLabel()
        setupPriceLabel()
        setupButton()
    }

    private func configureTableView() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func configureBottomView() {
        addSubview(bottomView)
        bottomView.addSubview(totalPriceTitleLabel)
        bottomView.addSubview(totalPriceLabel)
        bottomView.addSubview(placeOrderButton)

        bottomView.backgroundColor = .white
        bottomView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupPriceTitleLabel() {
        totalPriceTitleLabel.text = "ИТОГО"
        setupLabel(totalPriceTitleLabel, font: .systemFont(ofSize: 9.0, weight: .regular))

        NSLayoutConstraint.activate([
            totalPriceTitleLabel.leftAnchor.constraint(
                equalTo: bottomView.leftAnchor,
                constant: ProductConstants.sideIndent),
            totalPriceTitleLabel.topAnchor.constraint(
                greaterThanOrEqualTo: bottomView.topAnchor,
                constant: ProductConstants.interitemSpacing),
            totalPriceTitleLabel.bottomAnchor.constraint(
                equalTo: totalPriceLabel.topAnchor,
                constant: -ProductConstants.interitemSpacing / 2),
            totalPriceTitleLabel.rightAnchor.constraint(
                equalTo: placeOrderButton.leftAnchor,
                constant: -ProductConstants.interitemSpacing)
        ])
    }

    private func setupPriceLabel() {
        setupLabel(totalPriceLabel, font: .systemFont(ofSize: 16.0, weight: .semibold))

        NSLayoutConstraint.activate([
            totalPriceLabel.leftAnchor.constraint(
                equalTo: bottomView.leftAnchor,
                constant: ProductConstants.sideIndent),
            totalPriceLabel.bottomAnchor.constraint(
                equalTo: bottomView.bottomAnchor,
                constant: -ProductConstants.interitemSpacing),
            totalPriceLabel.topAnchor.constraint(
                equalTo: placeOrderButton.centerYAnchor),
            totalPriceLabel.rightAnchor.constraint(
                equalTo: placeOrderButton.leftAnchor,
                constant: -ProductConstants.interitemSpacing)
        ])
    }

    private func setupButton() {
        placeOrderButton.setTitleColor(.white, for: .normal)
        placeOrderButton.setTitleColor(.gray, for: .highlighted)
        placeOrderButton.setTitle("ОФОРМИТЬ ЗАКАЗ", for: .normal)
        placeOrderButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .regular)
        placeOrderButton.backgroundColor = .black
        placeOrderButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            placeOrderButton.topAnchor.constraint(
                equalTo: bottomView.topAnchor,
                constant: ProductConstants.interitemSpacing),
            placeOrderButton.bottomAnchor.constraint(
                equalTo: bottomView.bottomAnchor,
                constant: -ProductConstants.interitemSpacing),
            placeOrderButton.rightAnchor.constraint(
                equalTo: bottomView.rightAnchor,
                constant: -ProductConstants.sideIndent),
            placeOrderButton.heightAnchor.constraint(
                equalToConstant: ProductConstants.buttonsHeight),
            placeOrderButton.widthAnchor.constraint(
                equalTo: bottomView.widthAnchor,
                multiplier: 2 / 3)
        ])
    }

    private func setupLabel(_ label: UILabel, font: UIFont) {
        label.font = font
        label.textColor = .black
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
    }

}
