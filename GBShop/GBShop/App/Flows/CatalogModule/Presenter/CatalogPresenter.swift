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
        storageService: ProductsStorageService)

    func onViewDidLoad()
    func showProductDetail(for product: Product)
    func addToBasket(_ product: Product)
    func addToFavorite(_ product: Product)
    func scrollWillEnd()
}

// MARK: - CatalogPresenter

final class CatalogPresenter {

    // MARK: - Private roperties

    private weak var view: CatalogViewProtocol!
    private let coordinator: CatalogBaseCoordinator
    private let requestFactory: CatalogRequestFactory
    private let storageService: ProductsStorageService
    private var currentPage: Int
    private var currentCategory: Int
    private var nextPage: Int {
        get {
            currentPage += 1
            return currentPage
        }
    }

    // MARK: - Constructions

    init(
        view: CatalogViewProtocol,
        requestFactory: CatalogRequestFactory,
        coordinator: CatalogBaseCoordinator,
        storageService: ProductsStorageService
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.storageService = storageService
        currentPage = 0
        currentCategory = 0
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFCatalogResult) {
        switch response.result {
        case .success(let catalogResult):
            if catalogResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }

            guard let products = catalogResult.products else { return }

            self.view.catalogPageDidFetch(products)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct(for pageNumber: Int, categoryId: Int) {
        view.startLoadingSpinner()

        requestFactory.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.serverDidResponded(response)
                self.view.stopLoadingSpinner()
            }
        }
    }

}

// MARK: - Extensions

extension CatalogPresenter: CatalogPresenterProtocol {

    // MARK: - Functions

    func onViewDidLoad() {
        fetchProduct(for: currentPage, categoryId: currentCategory)
    }

    func showProductDetail(for product: Product) {
        // TODO: Show product view for goods
    }

    func addToBasket(_ product: Product) {
        // TODO: Show modal view to add goods to basket
    }

    func addToFavorite(_ product: Product) {
        // TODO: Add goods to favorite
    }

    func scrollWillEnd() {
        fetchProduct(for: nextPage, categoryId: currentCategory)
    }
}
