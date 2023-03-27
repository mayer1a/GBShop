//
//  ButtonsViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import UIKit

protocol ProductButtonsParentProtocol {
    func basketButtonDidTap()
    func favoriteButtonDidTap()
}

// MARK: - ButtonsViewController

final class ButtonsViewController: UIViewController {

    // MARK: - Private functions

    private var buttonsView: ButtonsView? {
        isViewLoaded ? view as? ButtonsView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ButtonsView()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        setupTargets()
    }

    // MARK: - Private functions

    private func setupTargets() {
        buttonsView?.basketButton.addTarget(self, action: #selector(basketButtonDidTap), for: .touchUpInside)
        buttonsView?.favoriteButton.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
    }

    @objc private func basketButtonDidTap(_ sender: UIButton) {
        guard let parent = parent as? ProductButtonsParentProtocol else { return }

        parent.basketButtonDidTap()
    }

    @objc private func favoriteButtonDidTap(_ sender: UIButton) {
        guard let parent = parent as? ProductButtonsParentProtocol else { return }

        parent.favoriteButtonDidTap()
    }
}
