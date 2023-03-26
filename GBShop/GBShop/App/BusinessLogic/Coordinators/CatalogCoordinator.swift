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
            goToGoodsScreen()
        }
    }

    private func goToGoodsScreen() {
        // TODO: create product screen trans and push here
    }

    private func goToBasket() {
        // TODO: create basket screen trans and modal present here
    }

}
