//
//  TabBarCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - TabBarBaseCoordinator

final class TabBarCoordinator: TabBarBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: MainBaseCoordinator?
    var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UITabBarController()
    lazy var catalogCoordinator: CatalogBaseCoordinator = CatalogCoordinator(self, assemblyBuilder: assemblyBuilder)
    lazy var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator(self, with: user, assemblyBuilder: assemblyBuilder)
    lazy var basketCoordinator: BasketCoordinator = BasketCoordinator(self, assemblyBuilder: assemblyBuilder)

    // MARK: - Private properties

    private var user: User?

    // MARK: - Constructions

    init(_ parentCoordinator: MainBaseCoordinator?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
        guard user != nil else {
            return rootViewController
        }

        let catalogViewController = catalogCoordinator.start()
        let catalogImage = UIImage(systemName: "list.bullet.circle")
        catalogViewController.tabBarItem = UITabBarItem(title: "каталог", image: catalogImage, tag: 0)

        let basketViewController = basketCoordinator.start()
        let basketImage = UIImage(systemName: "")
        basketViewController.tabBarItem = UITabBarItem(title: "корзина", image: basketImage, tag: 1)

        let profileViewController = profileCoordinator.start()
        let profileImage = UIImage(systemName: "person.crop.circle")
        profileViewController.tabBarItem = UITabBarItem(title: "профиль", image: profileImage, tag: 2)

        let viewControllers = [catalogViewController, basketViewController, profileViewController]
        (rootViewController as? UITabBarController)?.viewControllers = viewControllers
        (rootViewController as? UITabBarController)?.configure()

        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]?) {
        switch flow {
        case .tabBar(let tabFlow):
            handleTabFlow(for: tabFlow, from: flow, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    func setup(user: User) {
        self.user = user
    }

    // MARK: - Private functions

    private func handleTabFlow(for screen: TabFlow, from flow: AppFlow, userData: [UserDataKey: Any]?) {
        switch screen {
        case .catalogFlow:
            goToCatalog(flow, userData: userData)
        case .basketFlow:
            goToBasket(flow, userData: userData)
        case .profileScreen:
            goToProfile(flow, userData: userData)
        }
    }

    private func goToCatalog(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        catalogCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }

    private func goToBasket(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        basketCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }

    private func goToProfile(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        profileCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
}
