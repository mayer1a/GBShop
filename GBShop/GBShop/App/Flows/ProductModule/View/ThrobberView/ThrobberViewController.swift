//
//  ThrobberViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

final class ThrobberViewController: UIViewController {

    // MARK: - Private functions

    private var throbberView: ThrobberView? {
        isViewLoaded ? view as? ThrobberView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ThrobberView()
    }

    // MARK: - Functions

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        throbberView?.throbber.startAnimating()
    }

    override func removeFromParent() {
        throbberView?.throbber.stopAnimating()
        super.removeFromParent()
    }
}
