//
//  ModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

/// The module assembler method contract returns a view controller in a unified way
protocol ModuleBuilderProtocol {
    func createInitialModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createSignInModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createEditProfileModule(with user: User, coordinator: ProfileBaseCoordinator) -> UIViewController
    func createSignUpModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createCatalogModule(coordinator: CatalogBaseCoordinator) -> UIViewController
}

/// Assembly of all module components and injects dependencies
final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Functions

    func createInitialModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let view = InitialViewController()
        let storageService = UserCredentialsStorageService()
        let presenter = InitialPresenter(view: view, coordinator: coordinator, storageService: storageService)
        view.setPresenter(presenter)

        return view
    }

    func createSignInModule(coordinator: InitialBaseCoordinator) -> UIViewController {
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

    func createEditProfileModule(with user: User, coordinator: ProfileBaseCoordinator) -> UIViewController {
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

    func createSignUpModule(coordinator: InitialBaseCoordinator) -> UIViewController {
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

    func createCatalogModule(coordinator: CatalogBaseCoordinator) -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .blue
        return view
    }
}


