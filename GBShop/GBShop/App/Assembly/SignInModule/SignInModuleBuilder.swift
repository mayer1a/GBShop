//
//  SignInModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createSignInModule() -> UIViewController
    static func createMainModule(with user: User) -> UIViewController
    static func createSignUpModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Functions
    
    static func createSignInModule() -> UIViewController {
        let signInView = SignInViewController()
        let signInReq = RequestFactory().makeSignInRequestFatory()
        let presenter = SignInPresenter(view: signInView, requestFactory: signInReq)
        signInView.presenter = presenter

        return signInView
    }

    static func createMainModule(with user: User) -> UIViewController {
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

    static func createSignUpModule() -> UIViewController {
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
