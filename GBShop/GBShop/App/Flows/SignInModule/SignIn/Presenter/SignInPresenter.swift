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

    func signIn(email: String?, password: String?)
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
    let validator: Validator

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
        self.validator = .init()
    }

    // MARK: - Private functions

    private func validatePassword(_ password: String?) -> String? {
        do {
            try validator.validatePassword(password)
        } catch let error as Validator.ValidationError {
            // TODO: add to signInFailure property to send error message to view instead "print()"
            view?.signInFailure()
            print(error.localizedDescription)
            return nil
        } catch {
            return nil
        }
        return password
    }

    private func validateEmail(_ email: String?) -> String? {
        do {
            try validator.validateEmail(email)
        } catch let error as Validator.ValidationError {
            // TODO: add to signInFailure property to send error message to view instead "print()"
            view?.signInFailure()
            print(error.localizedDescription)
            return nil
        } catch {
            return nil
        }

        return email
    }
}

extension SignInPresenter: SignInPresenterProtocol {

    // MARK: - Functions

    func signIn(email: String?, password: String?) {
        guard
            let email = validateEmail(email),
            let password = validatePassword(password)
        else {
            return
        }

        view?.startLoadingSpinner()

        requestFactory.login(email: email, password: password) { [weak self] response in
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

                    self.storageService.createUser(from: user)
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
