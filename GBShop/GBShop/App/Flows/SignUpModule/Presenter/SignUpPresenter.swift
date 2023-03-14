//
//  SignUpPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 12.03.2023.
//

import UIKit

protocol SignUpViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func signUpFailure(with message: String?)
    func removeWarning()
}

protocol SignUpPresenterProtocol: AnyObject {
    init(
        view: SignUpViewProtocol,
        requestFactory: SignUpRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    )

    func signUpButtonTapped()
    func backButtonTapped()
    func inputFieldsTapped()
    func inputDidEndEdititng(_ sender: UITextField, of type: Constants.SignUpDictionartKey)
}

final class SignUpPresenter {

    // MARK: - Properties

    weak var view: SignUpViewProtocol!
    var coordinator: CoordinatorProtocol
    var signUpUser: RawSignUpModel
    let requestFactory: SignUpRequestFactory
    let storageService: UserCredentialsStorageService
    let validator: Validator
    let signUpModelFactory: SignUpUserModelFactory

    // MARK: - Constructions

    init(
        view: SignUpViewProtocol,
        requestFactory: SignUpRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        validator = .init()
        signUpUser = .init()
        signUpModelFactory = .init()
    }

    // MARK: - Private functions

    private func validateUserData() -> SignUpUser? {
        let user = signUpModelFactory.construct(from: signUpUser)

        do {
            try validator.validatePassword(user?.password)
            try validator.validateEmail(user?.email)
            try validator.validateUsername(user?.username)
            try validator.validateCard(user?.creditCard)
            try validator.validateBio(user?.bio)
        } catch let error as Validator.ValidationError {
            view?.signUpFailure(with: error.localizedDescription)
            return nil
        } catch {
            return nil
        }

        return user
    }

    private func serverDidResponded(with response: AFSignUpResult) {
        switch response.result {
        case .success(let signUpResult):
            guard signUpResult.result == 1 else {
                self.view.signUpFailure(with: signUpResult.userMessage)
                return
            }

            // TODO: create user profile and save to realm
        case .failure(_):
            self.view.signUpFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

}

// MARK: - Extension

extension SignUpPresenter: SignUpPresenterProtocol {

    // MARK: - Functions

    func signUpButtonTapped() {
        guard let user = validateUserData() else {
            return
        }

        view.startLoadingSpinner()

        requestFactory.registration(profile: user) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(with: response)
                self.view.stopLoadingSpinner()
            }
        }
    }

    func backButtonTapped() {
        coordinator.popViewController()
    }

    func inputFieldsTapped() {
        view.removeWarning()
    }

    func inputDidEndEdititng(_ sender: UITextField, of type: Constants.SignUpDictionartKey) {
        signUpUser[type] = sender.text ?? ""
    }

}
