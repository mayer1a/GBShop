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
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void)
}

// MARK: - CatalogPresenter

final class CatalogPresenter {

    // MARK: - Private roperties

    private weak var view: CatalogViewProtocol!
    private let coordinator: CatalogBaseCoordinator
    private let requestFactory: CatalogRequestFactory
    private let storageService: ProductsStorageService
    private var imageDownloader: ImageDownloaderProtocol!
    private var nextPage: Int?
    private var currentCategory: Int

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
        nextPage = 1
        currentCategory = 1
    }

    // MARK: - Functions

    func setupDownloader(_ imageDownloader: ImageDownloaderProtocol) {
        self.imageDownloader = imageDownloader
    }

    // MARK: - Private functions

    private func serverDidResponded(_ response: AFCatalogResult) {
        switch response.result {
        case .success(let catalogResult):
            if catalogResult.result == 0 {
                self.view.showFailure(with: nil)
                return
            }
            
            nextPage = catalogResult.nextPage

            guard let products = catalogResult.products else { return }

            self.view.catalogPageDidFetch(products)
            // TODO: Save fetched result to realm
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func fetchProduct(for pageNumber: Int?, categoryId: Int) {
        guard let pageNumber else { return }

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
        fetchProduct(for: nextPage, categoryId: currentCategory)
    }

    func showProductDetail(for product: Product) {
        coordinator.moveTo(flow: .tabBar(.catalogFlow(.goodsScreen)), userData: [.product: product])
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

    func getImage(from link: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }

        imageDownloader.getImage(fromUrl: url) { (image, _) in
            completion(image)
        }
    }
}
