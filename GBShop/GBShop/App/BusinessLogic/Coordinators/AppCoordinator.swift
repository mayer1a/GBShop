//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

/// The basic contract of any coordinator obliging to implement two properties for navigating the application
protocol BaseCoordinator {
    var navigationController: UINavigationController? { get }
    var assemblyBuilder: ModuleBuilderProtocol? { get }
}

/// Coordinator contract obliging to implement navigation methods on specific screens
protocol CoordinatorProtocol: BaseCoordinator {

    /// Shows the initialization screen every time the application is launched
    func initialViewController()
    func showSignUpFlow()
    func showSignInFlow()
    func showProfileFlow(with user: User)
    func popViewController()
}

/// The coordinator of the entire application, responsible for all screen transitions
final class AppCoordinator: CoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController?
    var assemblyBuilder: ModuleBuilderProtocol?

    // MARK: - Constructions

    init(navigationController: UINavigationController, assemblyBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func initialViewController() {
        guard
            let navigationController = navigationController,
            let initialViewController = assemblyBuilder?.createInitialModule(coordinator: self)
        else {
            return
        }

        navigationController.viewControllers = [initialViewController]
    }

    func showSignUpFlow() {
        guard
            let navigationController = navigationController,
            let signUpViewController = assemblyBuilder?.createSignUpModule(coordinator: self)
        else {
            return
        }

        navigationController.pushViewController(signUpViewController, animated: true)
    }

    func showSignInFlow() {
        guard
            let navigationController = navigationController,
            let signInViewController = assemblyBuilder?.createSignInModule(coordinator: self)
        else {
            return
        }

        navigationController.pushViewController(signInViewController, animated: true)
    }

    func showProfileFlow(with user: User) {
        guard
            let navigationController = navigationController,
            let mainViewController = assemblyBuilder?.createEditProfileModule(with: user, coordinator: self)
        else {
            return
        }

        navigationController.setViewControllers([mainViewController], animated: true)
    }

    func popViewController() {
        guard let navigationController = navigationController else { return }

        navigationController.popViewController(animated: true)
    }

}
