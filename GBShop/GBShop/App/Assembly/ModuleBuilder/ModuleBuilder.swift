//
//  ModuleBuilder.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

/// The module assembler method contract returns a view controller in a unified way
protocol ModuleBuilderProtocol {
    func createInitialModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createSignInModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createEditProfileModule(with user: User, coordinator: ProfileBaseCoordinator) -> UIViewController
    func createSignUpModule(coordinator: InitialBaseCoordinator) -> UIViewController
    func createCatalogModule(coordinator: CatalogBaseCoordinator, userId: Int) -> UIViewController
    func createProductModule(coordinator: CatalogBaseCoordinator, product: Product?, userId: Int) -> UIViewController
    func createReviewsSubmodule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController
    func createReviewsModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController
    func createBasketModule(coordinator: BasketBaseCoordinator, userId: Int) -> UIViewController
}

/// Assembly of all module components and injects dependencies
final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Private properties

    private let realmService: UserCredentialRealmStorage
    private let userStorageService: UserStorageServiceInterface
    private let productsStorageService: ProductsStorageServiceInterface
    private let analyticsManager: AnalyticsManagerInterface
    private let imageDownloader: ImageDownloaderProtocol
    private let factory: RequestFactory

    // MARK: - Constructions

    init(
        storageService: UserCredentialStorage,
        realmService: UserCredentialRealmStorage,
        analyticsService: AnalyticsEngine,
        factory: RequestFactory
    ) {
        self.realmService = realmService
        self.factory = factory
        analyticsManager = AnalyticsManager(service: analyticsService)
        userStorageService = UserCredentialsStorageService(storage: storageService, realm: realmService)
        productsStorageService = ProductsStorageService(realm: realmService)
        imageDownloader = ImageDownloader()
    }

    // MARK: - Functions

    func createInitialModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let view = InitialViewController()
        let presenter = InitialPresenter(view: view, coordinator: coordinator, storageService: userStorageService)
        view.setPresenter(presenter)

        return view
    }

    func createSignInModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let signInView = SignInViewController()
        let signInReq = factory.makeSignInRequestFatory()
        let presenter = SignInPresenter(
            view: signInView,
            requestFactory: signInReq,
            coordinator: coordinator,
            storageService: userStorageService)

        signInView.setPresenter(presenter)
        presenter.setupServices(analyticsManager: analyticsManager)

        return signInView
    }

    func createEditProfileModule(with user: User, coordinator: ProfileBaseCoordinator) -> UIViewController {
        let view = EditProfileViewController()
        let factory = factory.makeEditProfileRequestFactory()
        let presenter = EditProfilePresenter(
            user: user,
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: userStorageService)

        view.setPresenter(presenter)
        presenter.setupServices(analyticsManager: analyticsManager)

        return view
    }

    func createSignUpModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let view = SignUpViewController()
        let factory = factory.makeSignUpRequestFactory()
        let presenter = SignUpPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: userStorageService)

        view.setPresenter(presenter)
        presenter.setupServices(analyticsManager: analyticsManager)

        return view
    }

    func createCatalogModule(coordinator: CatalogBaseCoordinator, userId: Int) -> UIViewController {
        let view = CatalogViewController()
        let factory = factory.makeCatalogRequestFactory()
        let presenter = CatalogPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: productsStorageService,
            userId: userId)

        view.setPresenter(presenter)
        presenter.setupServices(imageDownloader: imageDownloader, analyticsManager: analyticsManager)
        
        return view
    }

    func createProductModule(coordinator: CatalogBaseCoordinator, product: Product?, userId: Int) -> UIViewController {
        let view = ProductViewController()
        let factory = factory.makeProductRequestFactory()
        let presenter = ProductPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: productsStorageService,
            product: product,
            userId: userId)

        view.setPresenter(presenter)
        presenter.setupServices(imageDownloader: imageDownloader, analyticsManager: analyticsManager)

        return view
    }

    func createReviewsSubmodule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController {
        let view = ReviewsViewController()
        let factory = factory.makeReviewsRequestFactory()
        let presenter = ReviewsSubmodulePresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            productId: product?.id)

        view.setupAsSubmodule()
        view.setPresenter(presenter)
        presenter.setupServices(analyticsManager: analyticsManager)

        return view
    }

    func createReviewsModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController {
        let view = ReviewsViewController()
        let factory = factory.makeReviewsRequestFactory()
        let presenter = ReviewsPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            productId: product?.id)

        view.setPresenter(presenter)
        presenter.setupServices(analyticsManager: analyticsManager)

        return view
    }

    func createBasketModule(coordinator: BasketBaseCoordinator, userId: Int) -> UIViewController {
        let view = BasketViewController()
        let factory = factory.makeBasketRequestFactory()
        let presenter = BasketPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            userId: userId)

        view.setPresenter(presenter)
        presenter.setupServices(imageDownloader: imageDownloader, analyticsManager: analyticsManager)

        return view
    }
}

