//
//  InitialViewPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

protocol InitialViewProtocol: AnyObject {
    var navigationController: UINavigationController { get }

    func showLoadingSpinner()
    func hideLoadingSpinner()
}

protocol InitialPresenterProtocol: AnyObject {
    func onViewDidLoad()
}

final class InitialViewPresenter {

    // MARK: - Properties

    weak var view: InitialViewProtocol!

    // MARK: - Constructions

    init(view: InitialViewProtocol) {
        self.view = view
    }

    // MARK: - Private functions

    func checkUserState() {
        view.showLoadingSpinner()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
            guard let self = self else { return }
            let debugIsUserAuthenticated = false

            self.view.hideLoadingSpinner()

            if debugIsUserAuthenticated {
                let debugUser = User(
                    id: 1, username: "foo", name: "Foo", email: "baz", creditCard: "0", lastname: "Bar", gender: .indeterminate, bio: "baz"
                )
                let debugMainViewController = ModuleBuilder.createMainModule(with: debugUser)
                self.view.navigationController.setViewControllers([debugMainViewController], animated: true)
            } else {
                let signInViewController = ModuleBuilder.createSignInModule()
                self.view.navigationController.pushViewController(signInViewController, animated: true)
            }
        }
    }
}

// MARK: - Extension

extension InitialViewPresenter: InitialPresenterProtocol {

    // MARK: - Functions

    func onViewDidLoad() {
        checkUserState()
    }
}
