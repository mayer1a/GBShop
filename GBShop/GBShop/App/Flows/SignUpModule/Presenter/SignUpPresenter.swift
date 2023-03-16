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

    func signUpButtonTapped(rawModel: SignUpRawModel)
    func backButtonTapped()
    func inputFieldsTapped()
}

final class SignUpPresenter {

    // MARK: - Properties

    weak var view: SignUpViewProtocol!
    var coordinator: CoordinatorProtocol
    var signUpUser: SignUpRawModel
    let requestFactory: SignUpRequestFactory
    let storageService: UserCredentialsStorageService
    let validator: Validator
    let userModelFactory: UserModelFactory

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
        userModelFactory = .init()
    }

    // MARK: - Private functions

    private func validateUserData(_ rawModel: SignUpRawModel) -> SignUpUser? {
        do {
            try validator.validatePassword(rawModel.password, repeatPassword: rawModel.repeatPassword)
            try validator.validateEmail(rawModel.email)
            try validator.validateUsername(rawModel.username)
            try validator.validateCard(rawModel.creditCard)
            try validator.validateBio(rawModel.bio)
            try validator.validateGender(rawModel.gender)
        } catch let error as Validator.ValidationError {
            view?.signUpFailure(with: error.localizedDescription)
            return nil
        } catch {
            return nil
        }

        return userModelFactory.construct(from: rawModel)
    }

    private func serverDidResponded(_ response: AFSignUpResult, with signUpUserModel: SignUpUser) {
        switch response.result {
        case .success(let signUpResult):
            guard signUpResult.result == 1 else {
                self.view.signUpFailure(with: signUpResult.userMessage)
                return
            }
            let user = userModelFactory.construct(from: signUpUserModel, with: signUpResult.userId)
            storageService.createUser(from: user)
            coordinator.showMainFlow(with: user)
        case .failure(_):
            self.view.signUpFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

}

// MARK: - Extension

extension SignUpPresenter: SignUpPresenterProtocol {

    // MARK: - Functions

    func signUpButtonTapped(rawModel: SignUpRawModel) {
        guard let signUpUserModel = validateUserData(rawModel) else {
            return
        }

        view.startLoadingSpinner()

        requestFactory.registration(profile: signUpUserModel) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response, with: signUpUserModel)
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
}
