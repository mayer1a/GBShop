//
//  BasketCoordinator.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

// MARK: - ProfileBaseCoordinator

final class BasketCoordinator: BasketBaseCoordinator {

    // MARK: - Properties

    var parentCoordinator: TabBarBaseCoordinator?
    var assemblyBuilder: ModuleBuilderProtocol?
    lazy var rootViewController: UIViewController = UIViewController()

    // MARK: - Private properties

    var userId: Int?

    // MARK: - Constructions

    init(_ parentCoordinator: TabBarBaseCoordinator?, assemblyBuilder: ModuleBuilderProtocol?) {
        self.parentCoordinator = parentCoordinator
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Functions

    func start() -> UIViewController {
        guard let userId else { return rootViewController }

        let basketViewController = ModuleBuilder().createBasketModule(coordinator: self, userId: userId)
        rootViewController = UINavigationController(rootViewController: basketViewController)
        navigationRootViewController?.setNavigationBarHidden(false, animated: true)
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

    func setup(userId: Int) {
        self.userId = userId
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
        // TODO: call coordinator.move() when payment screen ready
    }

}
