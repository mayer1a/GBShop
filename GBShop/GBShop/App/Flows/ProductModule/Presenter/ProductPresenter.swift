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
        storageService: ProductsStorageService,
        product: Product?)
    
    func addToBasket()
    func addToFavorite()
    func onViewDidLoad()
}

// MARK: - ProductPresenter

final class ProductPresenter {

    // MARK: - Private roperties

    private weak var view: ProductViewProtocol!
    private var imageDownloader: ImageDownloaderProtocol!
    private let requestFactory: GetProductRequestFactory
    private let coordinator: CatalogBaseCoordinator
    private let storageService: ProductsStorageService
    private let product: Product?

    // MARK: - Constructions

    init(
        view: ProductViewProtocol,
        requestFactory: GetProductRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageService,
        product: Product?
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        self.product = product
    }

    // MARK: - Functions

    func setupDownloader(_ imageDownloader: ImageDownloaderProtocol) {
        self.imageDownloader = imageDownloader
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFProductResult) {
        switch response.result {
        case .success(let productResult):
            guard
                productResult.result != 0,
                let detailedProduct = productResult.product,
                let product
            else {
                self.view.showFailure(with: nil)
                return
            }

            let productViewModel = ProductViewModelFactory.construct(from: product, with: detailedProduct)

            fetchImage(links: detailedProduct.images)
            view.productDidFetch(productViewModel)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct() {
        guard let product else { return }

        requestFactory.getProduct(productId: product.id) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
            }
        }
    }

    private func fetchImage(links: [String]) {
        let urls = links.compactMap { url -> URL? in URL(string: url) }

        imageDownloader.getImages(from: urls) { [weak self] (images, _) in
            self?.view.imagesDidFetch(images)
        }
    }
}

// MARK: - Extensions

extension ProductPresenter: ProductPresenterProtocol {

    // MARK: - Functions

    func addToBasket() {
        // TODO: make adding to cart when it's ready
    }

    func addToFavorite() {
        // TODO: make adding to favorite when it's ready
    }

    func onViewDidLoad() {
        fetchProduct()
    }

}
