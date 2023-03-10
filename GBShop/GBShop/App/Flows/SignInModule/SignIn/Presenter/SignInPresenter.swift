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
    func signInFailure()
    func removeWarning()
}

protocol SignInPresenterProtocol: AnyObject {
    init(
        view: SignInViewProtocol,
        requestFactory: SignInRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    )

    var user: User? { get }

    func signIn(username: String?, password: String?)
    func signUpButtonTapped()
    func inputFieldsTapped()
}

final class SignInPresenter {

    // MARK: - Properties

    weak var view: SignInViewProtocol!
    var coordinator: CoordinatorProtocol?
    let requestFactory: SignInRequestFactory
    let storageService: UserCredentialsStorageService
    var user: User?

    // MARK: - Constructions

    init(
        view: SignInViewProtocol,
        requestFactory: SignInRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
    }
}

extension SignInPresenter: SignInPresenterProtocol {

    // MARK: - Functions

    func signIn(username: String?, password: String?) {
        guard let username, let password else {
            view?.signInFailure()
            return
        }

        view?.startLoadingSpinner()

        requestFactory.login(userName: username, password: password) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                switch response.result {
                case .success(let signInResult):
                    guard
                        let user = signInResult.user
                    else {
                        self.view?.signInFailure()
                        break
                    }

                    // TODO: set user data to Realm
                    self.storageService.isUserAuthenticated = true
                    self.coordinator?.showMainFlow(with: user)
                case .failure(_):
                    self.view?.signInFailure()
                }

                self.view?.stopLoadingSpinner()
            }
        }
    }

    func signUpButtonTapped() {
        coordinator?.showSignUpFlow()
    }

    func inputFieldsTapped() {
        view?.removeWarning()
    }
}
