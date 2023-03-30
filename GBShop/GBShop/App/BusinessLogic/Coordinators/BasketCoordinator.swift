//
//  BasketCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

// MARK: - ProfileBaseCoordinator

final class BasketCoordinator: ProfileBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: TabBarBaseCoordinator?
    var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UIViewController()

    // MARK: - Constructions

    init(_ parentCoordinator: TabBarBaseCoordinator?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
//        let catalogViewController = ModuleBuilder().createCatalogModule(coordinator: self)
//        catalogViewController.title = "каталог"
//        rootViewController = UINavigationController(rootViewController: catalogViewController)
//        (rootViewController as? UINavigationController)?.setNavigationBarHidden(false, animated: true)
//        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]? = nil) {
        switch flow {
        case .tabBar(let tabFlow):
            switch tabFlow {
            case .basketFlow(let basketFlow):
                handleBasketFlow(for: basketFlow, userData: userData)
            default:
                parentCoordinator?.moveTo(flow: flow, userData: userData)
            }
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    // MARK: - Private functions

    private func handleBasketFlow(for screen: CoordinatorConstants.BasketFlow, userData: [UserDataKey: Any]?) {
        switch screen {
        case .basketScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .paymentScreen:
            goToPaymentScreen(userData: userData)
        }
    }

    private func goToPaymentScreen(userData: [UserDataKey: Any]?) {
//        guard
//            let product = userData?[.product] as? Product,
//            let productViewController = assemblyBuilder?.createProductModule(coordinator: self, product: product)
//        else {
//            return
//        }
//
//        let backButton = UIBarButtonItem(title: "корзина")
//        navigationRootViewController?.navigationBar.topItem?.backBarButtonItem = backButton
//        navigationRootViewController?.pushViewController(productViewController, animated: true)
//        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
    }

}
