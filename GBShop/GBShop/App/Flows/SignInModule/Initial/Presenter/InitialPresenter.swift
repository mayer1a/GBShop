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
    init(view: InitialViewProtocol, coordinator: CoordinatorProtocol, storageService: UserCredentialsStorageService)
    func onViewWillAppear()
}

final class InitialPresenter {

    // MARK: - Properties

    weak var view: InitialViewProtocol!
    var coordinator: CoordinatorProtocol?
    let storageService: UserCredentialsStorageService

    // MARK: - Constructions

    init(view: InitialViewProtocol, coordinator: CoordinatorProtocol, storageService: UserCredentialsStorageService) {
        self.view = view
        self.coordinator = coordinator
        self.storageService = storageService
    }

    // MARK: - Private functions

    func checkUserState() {
        view.showLoadingSpinner()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
            guard let self = self else { return }

            self.view.hideLoadingSpinner()

            if self.storageService.isUserAuthenticated {
                // TODO: get user data from Realm
                let debugUser = User(
                    id: 1, username: "foo", name: "Foo", email: "baz", creditCard: "0", lastname: "Bar", gender: .indeterminate, bio: "baz"
                )
                self.coordinator?.showMainFlow(with: debugUser)
            } else {
                self.coordinator?.showSignInFlow()
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
