//
//  CatalogPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

protocol CatalogViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func catalogPageDidFetch(_ products: [Product])
    func showFailure(with message: String?)
    func removeWarning()
}

protocol CatalogPresenterProtocol: AnyObject {
    init(
        view: CatalogViewProtocol,
        requestFactory: CatalogRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageServiceInterface,
        userId: Int)

    func onViewDidLoad()
    func showProductDetail(for product: Product)
    func addToBasket(_ product: Product)
    func addToFavorite(_ product: Product)
    func scrollWillEnd()
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void)
}

// MARK: - CatalogPresenter

final class CatalogPresenter {

    // MARK: - Private roperties

    private weak var view: CatalogViewProtocol!
    private let coordinator: CatalogBaseCoordinator
    private let requestFactory: CatalogRequestFactory
    private let basketRequstFactory: BasketRequestFactory
    private let storageService: ProductsStorageServiceInterface
    private var imageDownloader: ImageDownloaderProtocol!
    private var analyticsManager: AnalyticsManagerInterface!
    private var nextPage: Int?
    private var currentCategory: Int
    private var userId: Int

    // MARK: - Constructions

    init(
        view: CatalogViewProtocol,
        requestFactory: CatalogRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageServiceInterface,
        userId: Int
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        self.userId = userId
        basketRequstFactory = RequestFactory().makeBasketRequestFactory()
        nextPage = 1
        currentCategory = 1
    }

    // MARK: - Functions

    func setupServices(imageDownloader: ImageDownloaderProtocol, analyticsManager: AnalyticsManagerInterface) {
        self.imageDownloader = imageDownloader
        self.analyticsManager = analyticsManager
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFCatalogResult, page: Int, category: Int) {
        switch response.result {
        case .success(let catalogResult):
            if catalogResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }
            analyticsManager.log(.catalogViewed(page: page, category: category))
            nextPage = catalogResult.nextPage

            guard let products = catalogResult.products else { return }

            self.view.catalogPageDidFetch(products)
            // TODO: Save fetched result to realm
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct(for pageNumber: Int?, categoryId: Int) {
        guard let pageNumber else { return }

        view.startLoadingSpinner()

        requestFactory.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response, page: pageNumber, category: categoryId)
                self.view.stopLoadingSpinner()
            }
        }
    }

    private func handleAddProductResult(_ response: AFBasketResult, productId: Int) {
        switch response.result {
        case .success(let catalogResult):
            guard catalogResult.result != 0, let basket = catalogResult.basket else {
                view.showFailure(with: catalogResult.errorMessage)
                return
            }
            analyticsManager.log(.productAddedToBasket(productId: productId))
            if let items = (coordinator.parentCoordinator?.rootViewController as? UITabBarController)?.tabBar.items {
                let basketItem = items.first(where: { $0.image == .init(systemName: "basket.fill") })

                basketItem?.badgeValue = "\(basket.productsQuantity)"
                basketItem?.badgeColor = .black
            }
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

}

// MARK: - Extensions

extension CatalogPresenter: CatalogPresenterProtocol {

    // MARK: - Functions

    func onViewDidLoad() {
        fetchProduct(for: nextPage, categoryId: currentCategory)
    }

    func showProductDetail(for product: Product) {
        coordinator.moveTo(flow: .tabBar(.catalogFlow(.goodsScreen)), userData: [.product: product])
    }

    func addToBasket(_ product: Product) {
        let basketElement = BasketCellModelFactory.construct(from: product, with: 1)

        basketRequstFactory.addProduct(userId: userId, basketElement: basketElement) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handleAddProductResult(response, productId: basketElement.product.id)
            }
        }
    }

    func addToFavorite(_ product: Product) {
        // TODO: Add goods to favorite
    }

    func scrollWillEnd() {
        fetchProduct(for: nextPage, categoryId: currentCategory)
    }

    func getImage(from link: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }

        imageDownloader.getImage(fromUrl: url) { (image, _) in
            completion(image)
        }
    }
}
