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
    private(set) var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UITabBarController()
    private(set) lazy var catalogCoordinator: CatalogBaseCoordinator = {
        CatalogCoordinator(self, assemblyBuilder: assemblyBuilder)
    }()
    private(set) lazy var profileCoordinator: ProfileBaseCoordinator = {
        ProfileCoordinator(self, with: user, assemblyBuilder: assemblyBuilder)
    }()
    private(set) lazy var basketCoordinator: BasketBaseCoordinator = {
        BasketCoordinator(self, assemblyBuilder: assemblyBuilder)
    }()

    // MARK: - Private properties

    private var user: User?

    // MARK: - Constructions

    init(_ parentCoordinator: MainBaseCoordinator?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
        guard let user else {
            return rootViewController
        }

        catalogCoordinator.setup(userId: user.id)
        let catalogViewController = catalogCoordinator.start()
        let catalogImage = UIImage(systemName: "list.bullet.circle")
        catalogViewController.tabBarItem = UITabBarItem(title: "каталог", image: catalogImage, tag: 0)

        let profileViewController = profileCoordinator.start()
        let profileImage = UIImage(systemName: "person.crop.circle")
        profileViewController.tabBarItem = UITabBarItem(title: "профиль", image: profileImage, tag: 1)

        basketCoordinator.setup(userId: user.id)
        let basketViewController = basketCoordinator.start()
        let basketImage = UIImage(systemName: "basket.fill")
        basketViewController.tabBarItem = UITabBarItem(title: "корзина", image: basketImage, tag: 2)


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

    private func goToProfile(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        profileCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }

    private func goToBasket(_ flow: AppFlow, userData: [UserDataKey: Any]?) {
        basketCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
}
