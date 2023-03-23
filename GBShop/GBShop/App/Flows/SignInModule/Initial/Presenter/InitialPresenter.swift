//
//  InitialPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

protocol InitialViewProtocol: AnyObject {
    func showLoadingSpinner()
    func hideLoadingSpinner()
}

protocol InitialPresenterProtocol: AnyObject {
    init(view: InitialViewProtocol, coordinator: InitialBaseCoordinator, storageService: UserCredentialsStorageService)
    func onViewWillAppear()
}

final class InitialPresenter {

    // MARK: - Properties

    private weak var view: InitialViewProtocol!
    private let coordinator: InitialBaseCoordinator
    private let storageService: UserCredentialsStorageService

    // MARK: - Constructions

    init(view: InitialViewProtocol, coordinator: InitialBaseCoordinator, storageService: UserCredentialsStorageService) {
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
                let userData: [UserDataKey: Any] = [.user: self.storageService.user]
                self.coordinator.moveTo(flow: .tabBar(.catalogFlow(.catalogScreen)), userData: userData)
            } else {
                self.coordinator.moveTo(flow: .initial(.signInScreen), userData: nil)
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
