//
//  HeaderViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class HeaderViewController: UIViewController {

    // MARK: - Private properties

    private var headerView: HeaderView? {
        isViewLoaded ? view as? HeaderView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = HeaderView()
    }

    // MARK: - Functions

    func setupData(_ product: ProductViewModel) {
        headerView?.categoryLabel.text = product.category
        headerView?.nameLabel.text = product.name
    }
}
