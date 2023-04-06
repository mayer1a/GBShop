//
//  CoordinatorContracts.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - AppCoordinator

/// The main requirements for any coordinator are to contain a rootViewController ``UIViewController``,
///  an assemblyBuilder ``ModuleBuilderProtocol``, functions: ``start()`` that returns the ``rootViewController``,
///  a ``moveTo(flow:userData:)`` and a ``resetToRoot(animated:)-8jdrv``
protocol Coordinator {
    var rootViewController: UIViewController { get set }

    /// Builder for all modules
    var assemblyBuilder: ModuleBuilderProtocol? { get }

    /// The main function of the coordinator is the entry point that returns ``rootViewController``
    func start() -> UIViewController

    /// Allows you to navigate through the screens, changing child coordinators, using flow ``CoordinatorConstants.AppFlow``
    ///  and the ability to transfer data between coordinators using dictionaty with key ``UserDataKey`` and `Any` value
    func moveTo(flow: CoordinatorConstants.AppFlow, userData: [UserDataKey: Any]?)

    /// Allows you to go to the home screen of the coordinator with or without animation
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

/// The main coordinator contains two child coordinators: ``InitialBaseCoordinator`` for the ``InitialViewController`` of initialization,
///  ``SignInViewController`` authorization, ``SignUpViewController`` registration
///  and ``TabBarBaseCoordinator`` for the ``UITabBarController``
protocol MainBaseCoordinator: Coordinator, MainFlowCoordinator {
    var initialCoordinator: InitialBaseCoordinator { get }
    var tabBarCoordinator: TabBarBaseCoordinator { get }
}

/// Contains parent coordinator of type ``MainBaseCoordinator``
protocol MainFlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

// MARK: - TabBarBaseCoordinator

/// The tab coordinator contains two child coordinators: ``CatalogBaseCoordinator`` for the ``CatalogViewController`` - catalog,
///  ``ProductViewController`` - detailed product, ``ReviewsViewController`` - reviews
///  and ``ProfileBaseCoordinator`` for the ``EditProfileViewController``
protocol TabBarBaseCoordinator: Coordinator, MainFlowCoordinator {
    var catalogCoordinator: CatalogBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }

    func setup(user: User)
}

/// Contains parent coordinator of type ``TabBarBaseCoordinator``
protocol TabFlowCoordinator: AnyObject {
    var parentCoordinator: TabBarBaseCoordinator? { get set }
}

// MARK: - CatalogBaseCoordinator

protocol CatalogBaseCoordinator: Coordinator, TabFlowCoordinator {
    func setup(userId: Int)
}

// MARK: - CatalogBaseCoordinator

protocol BasketBaseCoordinator: Coordinator, TabFlowCoordinator {
    func setup(userId: Int)
}

// MARK: - ProfileBaseCoordinator

protocol ProfileBaseCoordinator: Coordinator, TabFlowCoordinator {}

// MARK: - InitialBaseCoordinator

protocol InitialBaseCoordinator: Coordinator, MainFlowCoordinator {}

