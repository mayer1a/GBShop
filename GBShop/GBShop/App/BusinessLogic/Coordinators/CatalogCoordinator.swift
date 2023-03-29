//
//  CatalogCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

// MARK: - CatalogBaseCoordinator

final class CatalogCoordinator: CatalogBaseCoordinator {

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
        let catalogViewController = ModuleBuilder().createCatalogModule(coordinator: self)
        catalogViewController.title = "каталог"
        rootViewController = UINavigationController(rootViewController: catalogViewController)
        (rootViewController as? UINavigationController)?.setNavigationBarHidden(false, animated: true)
        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
        return rootViewController
    }

    func moveTo(flow: AppFlow, userData: [UserDataKey : Any]? = nil) {
        switch flow {
        case .tabBar(let tabFlow):
            switch tabFlow {
            case .catalogFlow(let catalogFlow):
                handleCatalogFlow(for: catalogFlow, userData: userData)
            default:
                parentCoordinator?.moveTo(flow: flow, userData: userData)
            }
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }

    // MARK: - Private functions

    private func handleCatalogFlow(for screen: CatalogFlow, userData: [UserDataKey: Any]?) {
        switch screen {
        case .catalogScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .goodsScreen:
            goToGoodsScreen(userData: userData)
        case .reviewsScreen:
            goToReviewsScreen(userData: userData)
        }
    }

    private func goToGoodsScreen(userData: [UserDataKey: Any]?) {
        guard
            let product = userData?[.product] as? Product,
            let productViewController = assemblyBuilder?.createProductModule(coordinator: self, product: product),
            let reviewsViewController = assemblyBuilder?.createReviewsSubmodule(coordinator: self, product: product)
        else {
            return
        }

        (productViewController as? ProductViewController)?.setReviewsController(reviewsViewController)

        let backButton = UIBarButtonItem(title: "каталог")
        navigationRootViewController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationRootViewController?.pushViewController(productViewController, animated: true)
        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
    }

    private func goToReviewsScreen(userData: [UserDataKey: Any]?) {
        guard
            let product = userData?[.product] as? Product,
            let reviewsViewController = assemblyBuilder?.createReviewsModule(coordinator: self, product: product)
        else {
            return
        }

        let backButton = UIBarButtonItem(title: "назад")
        navigationRootViewController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationRootViewController?.pushViewController(reviewsViewController, animated: true)
        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
    }

    private func goToBasket() {
        // TODO: create basket screen trans and modal present here
    }

}
