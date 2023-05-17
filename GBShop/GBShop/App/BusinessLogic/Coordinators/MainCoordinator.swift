//
//  MainCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - MainBaseCoordinator

final class MainCoordinator: MainBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: MainBaseCoordinator?
    private(set) var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UINavigationController()
    private(set) lazy var initialCoordinator: InitialBaseCoordinator = {
        InitialCoordinator(self, assemblyBuilder: assemblyBuilder)
    }()
    private(set) lazy var tabBarCoordinator: TabBarBaseCoordinator = {
        TabBarCoordinator(self, assemblyBuilder: assemblyBuilder)
    }()

    // MARK: - Constructions

    init(assemblyBuilder: ModuleBuilderProtocol?) {
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
        rootViewController = initialCoordinator.start()

        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]? = nil) {
        switch flow {
        case .initial:
            goToInitialFlow(flow, userData: userData)
        case .tabBar:
            goToMainFlow(flow, userData: userData)
        }
    }

    func resetToRoot() -> Self {
        initialCoordinator.resetToRoot(animated: false)
        moveTo(flow: .initial(.signInScreen), userData: nil)
        return self
    }

    // MARK: - Private functions

    private func goToInitialFlow(_ flow: AppFlow, userData: [UserDataKey: Any ]?) {
        initialCoordinator.moveTo(flow: flow, userData: userData)
    }

    private func goToMainFlow(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        guard let user = userData?[.user] as? User else { return }

        tabBarCoordinator.setup(user: user)
        (rootViewController as? UINavigationController)?.setViewControllers([tabBarCoordinator.start()], animated: true)
        (rootViewController as? UINavigationController)?.setNavigationBarHidden(true, animated: true)
        tabBarCoordinator.moveTo(flow: flow, userData: userData)
    }
}
