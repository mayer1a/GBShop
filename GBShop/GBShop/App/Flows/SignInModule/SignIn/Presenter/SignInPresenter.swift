//
//  SignInPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 07.03.2023.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func signInFailure(with errorMessage: String?)
    func removeWarning()
}

protocol SignInPresenterProtocol: AnyObject {
    init(
        view: SignInViewProtocol,
        requestFactory: SignInRequestFactory,
        coordinator: InitialBaseCoordinator,
        storageService: UserCredentialsStorageService)

    func signIn(email: String?, password: String?)
    func signUpButtonTapped()
    func inputFieldsTapped()
}

final class SignInPresenter {

    // MARK: - Private properties

    private weak var view: SignInViewProtocol!
    private var coordinator: InitialBaseCoordinator
    private let requestFactory: SignInRequestFactory
    private let storageService: UserCredentialsStorageService

    // MARK: - Constructions

    init(
        view: SignInViewProtocol,
        requestFactory: SignInRequestFactory,
        coordinator: InitialBaseCoordinator,
        storageService: UserCredentialsStorageService
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFSignInResult) {
        switch response.result {
        case .success(let signInResult):
            guard
                let user = signInResult.user
            else {
                self.view?.signInFailure(with: signInResult.errorMessage)
                break
            }

            self.storageService.createUser(from: user)
            self.coordinator.moveTo(flow: .tabBar(.catalogFlow(.catalogScreen)), userData: [.user: user])
        case .failure(_):
            self.view?.signInFailure(with: "Сервер недоступен. Повторите попытку позже.")
        }
    }

}

// MARK: - Extensions

extension SignInPresenter: SignInPresenterProtocol {

    // MARK: - Functions

    func signIn(email: String?, password: String?) {
        guard let email, let password else { return }

        view?.startLoadingSpinner()

        requestFactory.login(email: email, password: password) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
                self.view?.stopLoadingSpinner()
            }
        }
    }

    func signUpButtonTapped() {
        coordinator.moveTo(flow: .initial(.signUpScreen), userData: nil)
    }

    func inputFieldsTapped() {
        view?.removeWarning()
    }
}
