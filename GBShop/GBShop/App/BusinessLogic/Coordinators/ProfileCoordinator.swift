//
//  ProfileCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - ProfileBaseCoordinator

final class ProfileCoordinator: ProfileBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: TabBarBaseCoordinator?
    private(set) var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UIViewController()

    // MARK: - Private properties

    private var user: User?

    // MARK: - Constructions

    init(_ parentCoordinator: TabBarBaseCoordinator?, with user: User?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
        self.user = user
    }

    // MARK: - Functions

    func start() -> UIViewController {
        guard let user, let assemblyBuilder else {
            return rootViewController
        }

        let profileViewController = assemblyBuilder.createEditProfileModule(with: user,coordinator: self)
        profileViewController.title = "профиль"
        rootViewController = UINavigationController(rootViewController: profileViewController)
        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]? = nil) {
        switch flow {
        case .tabBar(let tabFlow):
            handleProfileFlow(for: tabFlow, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    // MARK: - Private functions

    private func handleProfileFlow(for screen: TabFlow, userData: [UserDataKey: Any]?) {
        switch screen {
        case .profileScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        default:
            break
        }
    }
}
