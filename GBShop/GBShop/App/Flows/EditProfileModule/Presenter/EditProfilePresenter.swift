//
//  EditProfilePresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

protocol EditProfileViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func editFailure(with message: String?)
    func removeWarning()
}

protocol EditProfilePresenterProtocol: AnyObject {
    init(
        user: User,
        view: EditProfileViewProtocol,
        requestFactory: ProfileRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    )

    func editButtonTapped(rawModel: SignUpRawModel)
    func inputFieldsTapped()
}

final class EditProfilePresenter {

    // MARK: - Properties

    weak var view: EditProfileViewProtocol!
    var coordinator: CoordinatorProtocol
    var userRawModel: SignUpRawModel
    let requestFactory: ProfileRequestFactory
    let storageService: UserCredentialsStorageService
    let validator: Validator
    let userModelFactory: UserModelFactory

    // MARK: Private properties

    private var user: User

    // MARK: - Constructions

    init(
        user: User,
        view: EditProfileViewProtocol,
        requestFactory: ProfileRequestFactory,
        coordinator: CoordinatorProtocol,
        storageService: UserCredentialsStorageService
    ) {
        self.user = user
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        validator = .init()
        userRawModel = .init()
        userModelFactory = .init()
    }

    // MARK: - Private functions

    private func validateUserData(_ rawModel: SignUpRawModel) -> EditProfile? {
        do {
            if rawModel.password?.isEmpty == false {
                try validator.validatePassword(rawModel.password, repeatPassword: rawModel.repeatPassword)
            }
            try validator.validateEmail(rawModel.email)
            try validator.validateUsername(rawModel.username)
            try validator.validateCard(rawModel.creditCard)
            try validator.validateBio(rawModel.bio)
            try validator.validateGender(rawModel.gender)
        } catch let error as Validator.ValidationError {
            view?.editFailure(with: error.localizedDescription)
            return nil
        } catch {
            return nil
        }

        return userModelFactory.construct(from: rawModel, with: user)
    }

    private func serverDidResponded(_ response: AFEditResult, with editProfileModel: EditProfile) {
        switch response.result {
        case .success(let editProfileResult):
            guard editProfileResult.result == 0 else {
                self.view.editFailure(with: editProfileResult.errorMessage)
                return
            }

            user = userModelFactory.construct(from: editProfileModel, with: user.id)
            storageService.updateUser(from: user)
        case .failure(_):
            self.view.editFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
}

// MARK: - Extension

extension EditProfilePresenter: EditProfilePresenterProtocol {

    // MARK: - Functions

    func editButtonTapped(rawModel: SignUpRawModel) {
        guard let signUpUserModel = validateUserData(rawModel) else {
            return
        }

        view.startLoadingSpinner()

        requestFactory.editProfile(profile: signUpUserModel) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response, with: signUpUserModel)
                self.view.stopLoadingSpinner()
            }
        }
    }

    func inputFieldsTapped() {
        view.removeWarning()
    }
}
