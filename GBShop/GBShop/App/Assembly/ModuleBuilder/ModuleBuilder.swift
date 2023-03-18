//
//  ModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

/// The module assembler method contract returns a view controller in a unified way
protocol ModuleBuilderProtocol {
    func createInitialModule(coordinator: CoordinatorProtocol) -> UIViewController
    func createSignInModule(coordinator: CoordinatorProtocol) -> UIViewController
    func createEditProfileModule(with user: User, coordinator: CoordinatorProtocol) -> UIViewController
    func createSignUpModule(coordinator: CoordinatorProtocol) -> UIViewController
}

/// Assembly of all module components and injects dependencies
final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Functions

    func createInitialModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = InitialViewController()
        let storageService = UserCredentialsStorageService()
        let presenter = InitialPresenter(view: view, coordinator: coordinator, storageService: storageService)
        view.setPresenter(presenter)

        return view
    }

    func createSignInModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let signInView = SignInViewController()
        let signInReq = RequestFactory().makeSignInRequestFatory()
        let storageService = UserCredentialsStorageService()
        let presenter = SignInPresenter(
            view: signInView,
            requestFactory: signInReq,
            coordinator: coordinator,
            storageService: storageService)

        signInView.setPresenter(presenter)

        return signInView
    }

    func createEditProfileModule(with user: User, coordinator: CoordinatorProtocol) -> UIViewController {
        let view = EditProfileViewController()
        let factory = RequestFactory().makeEditProfileRequestFactory()
        let storageService = UserCredentialsStorageService()
        let presenter = EditProfilePresenter(
            user: user,
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService)

        view.setPresenter(presenter)

        return view
    }

    func createSignUpModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = SignUpViewController()
        let factory = RequestFactory().makeSignUpRequestFactory()
        let storageService = UserCredentialsStorageService()
        let presenter = SignUpPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService)

        view.setPresenter(presenter)

        return view
    }
}


