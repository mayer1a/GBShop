//
//  ProductPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 26.03.2023.
//

import UIKit

protocol ProductViewProtocol: AnyObject {
    func showFailure(with message: String?)
    func removeWarning()
    func productDidFetch(_ product: ProductViewModel)
    func imagesDidFetch(_ images: [UIImage?])
}

protocol ProductPresenterProtocol: AnyObject {
    init(
        view: ProductViewProtocol,
        requestFactory: GetProductRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageServiceInterface,
        product: Product?,
        userId: Int)
    
    func addToBasket()
    func addToFavorite()
    func onViewDidLoad()
    func showAllReviews()
    func addReviewButtonDidTap()
}

// MARK: - ProductPresenter

final class ProductPresenter {

    // MARK: - Private roperties

    private weak var view: ProductViewProtocol!
    private var imageDownloader: ImageDownloaderProtocol!
    private let requestFactory: GetProductRequestFactory
    private let coordinator: CatalogBaseCoordinator
    private let storageService: ProductsStorageServiceInterface
    private let basketRequstFactory: BasketRequestFactory
    private var analyticsManager: AnalyticsManagerInterface!
    private let product: Product?
    private let userId: Int

    // MARK: - Constructions

    init(
        view: ProductViewProtocol,
        requestFactory: GetProductRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageServiceInterface,
        product: Product?,
        userId: Int
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        self.product = product
        self.userId = userId
        basketRequstFactory = RequestFactory().makeBasketRequestFactory()
    }

    // MARK: - Functions

    func setupServices(imageDownloader: ImageDownloaderProtocol, analyticsManager: AnalyticsManagerInterface) {
        self.imageDownloader = imageDownloader
        self.analyticsManager = analyticsManager
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFProductResult, productId: Int) {
        switch response.result {
        case .success(let productResult):
            guard
                productResult.result != 0,
                let detailedProduct = productResult.product,
                let product
            else {
                view.showFailure(with: nil)
                return
            }

            analyticsManager.log(.detailProductViewed(productId: productId))
            let productViewModel = ProductViewModelFactory.construct(from: product, with: detailedProduct)

            fetchImage(links: detailedProduct.images)
            view.productDidFetch(productViewModel)
            // TODO: Save fetched result to realm
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct() {
        guard let product else { return }

        requestFactory.getProduct(productId: product.id) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response, productId: product.id)
            }
        }
    }

    private func fetchImage(links: [String]) {
        let urls = links.compactMap { url -> URL? in URL(string: url) }

        imageDownloader.getImages(from: urls) { [weak self] (images, _) in
            self?.view.imagesDidFetch(images)
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
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
}

// MARK: - Extensions

extension ProductPresenter: ProductPresenterProtocol {

    // MARK: - Functions

    func addToBasket() {
        guard let product else { return }
        
        let basketElement = BasketCellModelFactory.construct(from: product, with: 1)

        basketRequstFactory.addProduct(userId: userId, basketElement: basketElement) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.handleAddProductResult(response, productId: basketElement.product.id)
            }
        }
    }

    func addToFavorite() {
        // TODO: make adding to favorite when it's ready
    }

    func onViewDidLoad() {
        fetchProduct()
    }

    func showAllReviews() {
        guard let product else { return }
        
        coordinator.moveTo(flow: .tabBar(.catalogFlow(.reviewsScreen)), userData: [.product: product])
    }

    func addReviewButtonDidTap() {
        // TODO: call coordinator moveTo method, on add review screen will call analyticsManager.log
    }

}
