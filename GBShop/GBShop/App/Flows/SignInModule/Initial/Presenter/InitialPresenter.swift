//
//  InitialPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

protocol InitialViewProtocol: AnyObject {
    var initialNavigationController: UINavigationController? { get }

    func showLoadingSpinner()
    func hideLoadingSpinner()
}

protocol InitialPresenterProtocol: AnyObject {
    func onViewWillAppear()
}

final class InitialPresenter {

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
            // TODO: get value of isUserAuthenticated from UserDefaults
            let debugIsUserAuthenticated = false

            self.view.hideLoadingSpinner()

            if debugIsUserAuthenticated {
                // TODO: get user data from Realm
                let debugUser = User(
                    id: 1, username: "foo", name: "Foo", email: "baz", creditCard: "0", lastname: "Bar", gender: .indeterminate, bio: "baz"
                )
                let debugMainViewController = ModuleBuilder.createMainModule(with: debugUser)
                self.view.initialNavigationController?.setViewControllers([debugMainViewController], animated: true)
            } else {
                let signInViewController = ModuleBuilder.createSignInModule()
                self.view.initialNavigationController?.pushViewController(signInViewController, animated: true)
            }
        }
    }
}

// MARK: - Extension

extension InitialPresenter: InitialPresenterProtocol {

    // MARK: - Functions

    func onViewWillAppear() {
        checkUserState()
    }
}
