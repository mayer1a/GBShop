//
//  CoordinatorContracts.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - AppCoordinator

protocol Coordinator {
    var rootViewController: UIViewController { get set }
    var assemblyBuilder: ModuleBuilderProtocol? { get }

    func start() -> UIViewController
    func moveTo(flow: CoordinatorConstants.AppFlow, userData: [UserDataKey: Any]?)
    @discardableResult func resetToRoot(animated: Bool) -> Self
}

extension Coordinator {

    // MARK: - Properties

    var navigationRootViewController: UINavigationController? {
        get {
            rootViewController as? UINavigationController
        }
    }

    // MARK: - Functions

    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}

// MARK: - MainBaseCoordinator

protocol MainBaseCoordinator: Coordinator, MainFlowCoordinator {
    var initialCoordinator: InitialBaseCoordinator { get }
    var tabBarCoordinator: TabBarBaseCoordinator { get }
}

protocol MainFlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

// MARK: - TabBarBaseCoordinator

protocol TabBarBaseCoordinator: Coordinator, MainFlowCoordinator {
    var catalogCoordinator: CatalogBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }

    func setup(user: User)
}

protocol TabFlowCoordinator: AnyObject {
    var parentCoordinator: TabBarBaseCoordinator? { get set }
}

// MARK: - CatalogBaseCoordinator

protocol CatalogBaseCoordinator: Coordinator, TabFlowCoordinator {}

// MARK: - ProfileBaseCoordinator

protocol ProfileBaseCoordinator: Coordinator, TabFlowCoordinator {}

// MARK: - InitialBaseCoordinator

protocol InitialBaseCoordinator: Coordinator, MainFlowCoordinator {}

