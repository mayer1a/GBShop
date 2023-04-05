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
        coordinator: InitialBaseCoordinator,
        storageService: UserCredentialsStorageService
    )

    func signUpButtonTapped(rawModel: SignUpRawModel)
    func backButtonTapped()
    func inputFieldsTapped()
}

final class SignUpPresenter {

    // MARK: - Private properties

    private weak var view: SignUpViewProtocol!
    private var signUpUser: SignUpRawModel
    private let coordinator: InitialBaseCoordinator
    private let requestFactory: SignUpRequestFactory
    private let storageService: UserCredentialsStorageService
    private var analyticsManager: AnalyticsManagerInterface!
    private let validator: Validator
    private let userModelFactory: UserModelFactory

    // MARK: - Constructions

    init(
        view: SignUpViewProtocol,
        requestFactory: SignUpRequestFactory,
        coordinator: InitialBaseCoordinator,
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

    // MARK: - Functions

    func setupServices(analyticsManager: AnalyticsManagerInterface) {
        self.analyticsManager = analyticsManager
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
            view?.signUpFailure(with: error.localizedDescription)
            return nil
        }

        return userModelFactory.construct(from: rawModel)
    }

    private func serverDidResponded(_ response: AFSignUpResult, with signUpUserModel: SignUpUser) {
        switch response.result {
        case .success(let signUpResult):
            if signUpResult.result == 0 {
                analyticsManager.log(.registrationFailed(signUpResult.userMessage))
                view.signUpFailure(with: signUpResult.userMessage)
                return
            }

            guard let userId = signUpResult.userId else { return }

            analyticsManager.log(.registrationSucceeded)
            let user = userModelFactory.construct(from: signUpUserModel, with: userId)
            storageService.createUser(from: user)
            coordinator.moveTo(flow: .tabBar(.catalogFlow(.catalogScreen)), userData: [.user: user])
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.signUpFailure(with: "Сервер недоступен. Повторите попытку позже.")
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
        coordinator.resetToRoot(animated: true)
    }

    func inputFieldsTapped() {
        view.removeWarning()
    }
}
