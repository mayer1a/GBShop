//
//  InitialCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - InitialBaseCoordinator

final class InitialCoordinator: InitialBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: MainBaseCoordinator?
    private(set) var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UIViewController()

    // MARK: - Constructions

    init(_ parentCoordinator: MainBaseCoordinator?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
        guard let assemblyBuilder else {
            return rootViewController
        }
        let initialViewController = assemblyBuilder.createInitialModule(coordinator: self)
        rootViewController = UINavigationController(rootViewController: initialViewController)
        return rootViewController
    }

    func goToCatalog() {
        parentCoordinator?.moveTo(flow: .tabBar(.catalogFlow(.catalogScreen)), userData: nil)
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]?) {
        switch flow {
        case .initial(let initialFlow):
            handleInitialFlow(for: initialFlow)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    // MARK: - Private functions

    private func handleInitialFlow(for screen: InitialFlow) {
        switch screen {
        case .initialScreen:
            navigationRootViewController?.popToRootViewController(animated: true) // ???
        case .signInScreen:
            goToSignInScreen()
        case .signUpScreen:
            goToSignUpScreen()
        }
    }

    private func goToSignInScreen() {
        guard let signInViewController = assemblyBuilder?.createSignInModule(coordinator: self) else { return }
        navigationRootViewController?.setViewControllers([signInViewController], animated: true)
        navigationRootViewController?.setNavigationBarHidden(true, animated: true)
    }

    private func goToSignUpScreen() {
        guard let signUpViewController = assemblyBuilder?.createSignUpModule(coordinator: self) else { return }
        signUpViewController.title = "Регистрация"
        navigationRootViewController?.pushViewController(signUpViewController, animated: true)
        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
    }
}
