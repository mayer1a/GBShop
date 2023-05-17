//
//  DescriptionViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {

    // MARK: - Private properties

    private var descriptionView: DescriptionView? {
        isViewLoaded ? view as? DescriptionView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = DescriptionView()
    }

    // MARK: - Functions

    func setupData(_ product: ProductViewModel) {
        descriptionView?.priceLabel.text = product.price
        descriptionView?.descriptionLabel.text = product.description
    }

}
