//
//  ModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createInitialModule(coordinator: CoordinatorProtocol) -> UIViewController
    func createSignInModule(coordinator: CoordinatorProtocol) -> UIViewController
    func createMainModule(with user: User, coordinator: CoordinatorProtocol) -> UIViewController
    func createSignUpModule(coordinator: CoordinatorProtocol) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Functions

    func createInitialModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = InitialViewController()
        let storageService = UserCredentialsStorageService()
        let presenter = InitialPresenter(view: view, coordinator: coordinator, storageService: storageService)
        view.setPresenter(presenter: presenter)

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

        signInView.presenter = presenter

        return signInView
    }

    func createMainModule(with user: User, coordinator: CoordinatorProtocol) -> UIViewController {
        // TODO: add MainModule assembly components when ready
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Добро пожаловать, \(user.name) \(user.lastname)!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.backgroundColor = .systemBackground
        welcomeLabel.font = .systemFont(ofSize: 20, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.view.addSubview(welcomeLabel)

        NSLayoutConstraint.activate([
            welcomeLabel.leftAnchor.constraint(equalTo: viewController.view.leftAnchor, constant: 20),
            welcomeLabel.rightAnchor.constraint(equalTo: viewController.view.rightAnchor, constant: -20),
            welcomeLabel.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor)
        ])

        return viewController
    }

    func createSignUpModule(coordinator: CoordinatorProtocol) -> UIViewController {
        // TODO: add SignUpModule assembly components when ready
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Окно регистрации!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.backgroundColor = .systemBackground
        welcomeLabel.font = .systemFont(ofSize: 30, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.view.addSubview(welcomeLabel)

        NSLayoutConstraint.activate([
            welcomeLabel.leftAnchor.constraint(equalTo: viewController.view.leftAnchor, constant: 20),
            welcomeLabel.rightAnchor.constraint(equalTo: viewController.view.rightAnchor, constant: -20),
            welcomeLabel.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor)
        ])

        return viewController
    }
}


