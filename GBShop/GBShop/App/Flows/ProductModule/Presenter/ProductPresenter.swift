//
//  ProductPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 26.03.2023.
//

import UIKit
import Alamofire

protocol ProductViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func showFailure(with message: String?)
    func removeWarning()
    func productDidFetch(_ product: DetailedProduct)
}

protocol ProductPresenterProtocol: AnyObject {
    init(
        view: ProductViewProtocol,
        requestFactory: GetProductRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageService,
        product: Product?)
    
    func addToBasket(_ product: Product)
    func addToFavorite(_ product: Product)
    func getImages(from link: [String], completion: @escaping ([UIImage]) -> Void)
}


final class ProductPresenter {

    // MARK: - Private roperties

    private weak var view: ProductViewProtocol!
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

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFDataResponse<ProductResult>) {
        switch response.result {
        case .success(let productResult):
            if productResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }

            guard let detailedProduct = productResult.product else { return }

            view.productDidFetch(detailedProduct)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct() {
        guard let product else { return }

        view.startLoadingSpinner()

        requestFactory.getProduct(productId: product.id) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
                self.view.stopLoadingSpinner()
            }
        }
    }
}

// MARK: - Extensions

extension ProductPresenter: ProductPresenterProtocol {

    // MARK: - Functions

    func addToBasket(_ product: Product) {
        // TODO: make adding to cart when it's ready
    }

    func addToFavorite(_ product: Product) {
        // TODO: sdelat' dobavleniye v izbrannoye, kogda ono budet gotova
    }

    func getImages(from link: [String], completion: @escaping ([UIImage]) -> Void) {
        completion([UIImage()])
    }

}
