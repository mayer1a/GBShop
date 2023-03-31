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
    func createCatalogModule(coordinator: CatalogBaseCoordinator) -> UIViewController
    func createProductModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController
    func createReviewsSubmodule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController
    func createReviewsModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController
    func createBasketModule(coordinator: BasketBaseCoordinator, userId: Int) -> UIViewController
}

/// Assembly of all module components and injects dependencies
final class ModuleBuilder: ModuleBuilderProtocol {

    // MARK: - Private properties

    private var realmService: UserCredentialRealmStorage = RealmLayer()

    // MARK: - Functions

    func createInitialModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let view = InitialViewController()
        let storageService = UserCredentialsStorageService(realm: realmService)
        let presenter = InitialPresenter(view: view, coordinator: coordinator, storageService: storageService)
        view.setPresenter(presenter)

        return view
    }

    func createSignInModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let signInView = SignInViewController()
        let signInReq = RequestFactory().makeSignInRequestFatory()
        let storageService = UserCredentialsStorageService(realm: realmService)
        let presenter = SignInPresenter(
            view: signInView,
            requestFactory: signInReq,
            coordinator: coordinator,
            storageService: storageService)

        signInView.setPresenter(presenter)

        return signInView
    }

    func createEditProfileModule(with user: User, coordinator: ProfileBaseCoordinator) -> UIViewController {
        let view = EditProfileViewController()
        let factory = RequestFactory().makeEditProfileRequestFactory()
        let storageService = UserCredentialsStorageService(realm: realmService)
        let presenter = EditProfilePresenter(
            user: user,
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService)

        view.setPresenter(presenter)

        return view
    }

    func createSignUpModule(coordinator: InitialBaseCoordinator) -> UIViewController {
        let view = SignUpViewController()
        let factory = RequestFactory().makeSignUpRequestFactory()
        let storageService = UserCredentialsStorageService(realm: realmService)
        let presenter = SignUpPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService)

        view.setPresenter(presenter)

        return view
    }

    func createCatalogModule(coordinator: CatalogBaseCoordinator) -> UIViewController {
        let view = CatalogViewController()
        let factory = RequestFactory().makeCatalogRequestFactory()
        let storageService = ProductsStorageService(realm: realmService)
        let presenter = CatalogPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService)

        view.setPresenter(presenter)
        presenter.setupDownloader(ImageDownloader())
        
        return view
    }

    func createProductModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController {
        let view = ProductViewController()
        let factory = RequestFactory().makeProductRequestFactory()
        let storageService = ProductsStorageService(realm: realmService)
        let presenter = ProductPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            storageService: storageService,
            product: product)

        view.setPresenter(presenter)
        presenter.setupDownloader(ImageDownloader())

        return view
    }

    func createReviewsSubmodule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController {
        let view = ReviewsViewController()
        let factory = RequestFactory().makeReviewsRequestFactory()
        let presenter = ReviewsSubmodulePresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            productId: product?.id)

        view.setupAsSubmodule()
        view.setPresenter(presenter)

        return view
    }

    func createReviewsModule(coordinator: CatalogBaseCoordinator, product: Product?) -> UIViewController {
        let view = ReviewsViewController()
        let factory = RequestFactory().makeReviewsRequestFactory()
        let presenter = ReviewsPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            productId: product?.id)

        view.setPresenter(presenter)

        return view
    }

    func createBasketModule(coordinator: BasketBaseCoordinator, userId: Int) -> UIViewController {
        let view = BasketViewController()
        let factory = RequestFactory().makeBasketRequestFactory()
        let presenter = BasketPresenter(
            view: view,
            requestFactory: factory,
            coordinator: coordinator,
            userId: userId)

        view.setPresenter(presenter)
        presenter.setupDownloader(ImageDownloader())

        return view
    }
}

