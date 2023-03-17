//
//  InitialViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

final class InitialViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: InitialPresenterProtocol!

    private var initialView: InitialView? {
        isViewLoaded ? view as? InitialView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = InitialView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: InitialPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Private functions

    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Extension

extension InitialViewController: InitialViewProtocol {

    // MARK: - Functions

    func showLoadingSpinner() {
        initialView?.loadingSpinner.startAnimating()
    }

    func hideLoadingSpinner() {
        initialView?.loadingSpinner.stopAnimating()
    }
}
