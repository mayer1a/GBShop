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
    private var analyticsManager: AnalyticsManagerInterface!

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

    // MARK: - Functions

    func setupServices(analyticsManager: AnalyticsManagerInterface) {
        self.analyticsManager = analyticsManager
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFSignInResult) {
        switch response.result {
        case .success(let signInResult):
            guard
                let user = signInResult.user
            else {
                analyticsManager.log(.loginFailed(signInResult.errorMessage))
                self.view?.signInFailure(with: signInResult.errorMessage)
                break
            }

            analyticsManager.log(.loginSucceeded)
            storageService.createUser(from: user)
            coordinator.moveTo(flow: .tabBar(.catalogFlow(.catalogScreen)), userData: [.user: user])
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view?.signInFailure(with: "Сервер недоступен. Повторите попытку позже.")
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
