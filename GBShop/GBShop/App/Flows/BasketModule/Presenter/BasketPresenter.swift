//
//  BasketPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import UIKit

protocol BasketViewProtocol: AnyObject {
    func showFailure(with message: String?)
    func removeWarning()
    func basketDidFetch(_ basket: BasketModel)
    func insertProductRows(at indexes: [IndexPath], basket: BasketModel)
    func updateProductRows(at indexes: [IndexPath], basket: BasketModel)
    func deleteProductRows(at indexes: [IndexPath], basket: BasketModel)
    func basketDidPay()
    func setDisabledWhileSending(at index: Int?)
}

protocol BasketPresenterProtocol: AnyObject {
    init(
        view: BasketViewProtocol,
        requestFactory: BasketRequestFactory,
        coordinator: BasketBaseCoordinator,
        userId: Int)
    
    func onViewWillAppear()
    func placeOrderButtonDidTap()
    func productQuantityDidChange(_ product: BasketCellModel, quantity: Int, index: Int)
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void)
}

// MARK: - BasketPresenter

final class BasketPresenter {
    
    // MARK: - Private properties
    
    private weak var view: BasketViewProtocol!
    private let coordinator: BasketBaseCoordinator
    private let requestFactory: BasketRequestFactory
    private var imageDownloader: ImageDownloaderProtocol!
    private var analyticsManager: AnalyticsManagerInterface!
    private var userId: Int
    private var basket: BasketModel?
    
    // MARK: - Constructions
    
    init(
        view: BasketViewProtocol,
        requestFactory: BasketRequestFactory,
        coordinator: BasketBaseCoordinator,
        userId: Int
    ) {
        self.view = view
        self.requestFactory = requestFactory
        self.coordinator = coordinator
        self.userId = userId
    }
    
    // MARK: Functions
    
    func setupServices(imageDownloader: ImageDownloaderProtocol, analyticsManager: AnalyticsManagerInterface) {
        self.imageDownloader = imageDownloader
        self.analyticsManager = analyticsManager
    }
    
    // MARK: - Private functions

    @discardableResult
    private func handleResult(result: GetBasketResult, _ action: ([IndexPath], BasketModel) -> Void) -> Bool {
        guard result.result != 0, let basket = result.basket else {
            view.showFailure(with: result.errorMessage)
            return false
        }
        
        let userBasket = BasketCellModelFactory.construct(from: basket)
        let indexes = getIndexes(for: userBasket, with: self.basket)
        self.basket = userBasket

        setupBadge()
        action(indexes, userBasket)

        return true
    }
    
    private func basketDidFetch(_ response: AFBasketResult) {
        switch response.result {
        case .success(let basketResult):
            guard basketResult.result != 0, let userBasket = basketResult.basket else {
                self.view.showFailure(with: basketResult.errorMessage)
                return
            }
            
            let basketModel = BasketCellModelFactory.construct(from: userBasket)
            basket = basketModel
            setupBadge()
            view.basketDidFetch(basketModel)
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
    private func handleAddProductResponse(_ response: AFBasketResult, productId: Int) {
        switch response.result {
        case .success(let basketResult):
            let isSuccess = handleResult(result: basketResult, view.insertProductRows)
            if isSuccess {
                analyticsManager.log(.serverError(basketResult.errorMessage))
            } else {
                analyticsManager.log(.productAddedToBasket(productId: productId))
            }
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
    private func handleEditProductResponse(_ response: AFBasketResult) {
        switch response.result {
        case .success(let basketResult):
            handleResult(result: basketResult, view.updateProductRows)
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
    private func handleRemoveProductResponse(_ response: AFBasketResult, productId: Int) {
        switch response.result {
        case .success(let basketResult):
            let isSuccess = handleResult(result: basketResult, view.deleteProductRows)
            if isSuccess {
                analyticsManager.log(.serverError(basketResult.errorMessage))
            } else {
                analyticsManager.log(.productRemovedFromBasket(productId: productId))
            }
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
    private func handlePayBasketResponse(_ response: AFPayBasketResult) {
        switch response.result {
        case .success(let basketResult):
            switch basketResult.result {
            case -1...0:
                analyticsManager.log(.basketFailedPaid(basketResult.errorMessage))
                view.showFailure(with: basketResult.errorMessage)
                return
            default:
                break
            }
            
            basket = nil
            setupBadge()
            view.basketDidPay()
            analyticsManager.log(.basketSuccessfullyPaid)
        case .failure(let error):
            analyticsManager.log(.serverError(error.localizedDescription))
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }
    
    private func fetchBasket() {
        requestFactory.getBasket(userId: userId) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.basketDidFetch(response)
            }
        }
    }
    
    private func addProduct(_ product: BasketCellModel) {
        guard let basketElement = BasketCellModelFactory.construct(from: product) else { return }
        
        requestFactory.addProduct(userId: userId, basketElement: basketElement) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handleAddProductResponse(response, productId: basketElement.product.id)
            }
        }
    }
    
    private func editProduct(_ basketElement: BasketElement) {
        requestFactory.editProduct(userId: userId, basketElement: basketElement) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handleEditProductResponse(response)
            }
        }
    }
    
    private func removeProduct(_ basketElement: BasketElement) {
        requestFactory.removeProduct(userId: userId, productId: basketElement.product.id) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handleRemoveProductResponse(response, productId: basketElement.product.id)
            }
        }
    }
    
    private func payBasket() {
        requestFactory.payBasket(userId: userId) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.handlePayBasketResponse(response)
            }
        }
    }

    private func setupBadge() {
        if let items = (coordinator.parentCoordinator?.rootViewController as? UITabBarController)?.tabBar.items {
            let basketItem = items.first(where: { $0.image == .init(systemName: "basket.fill") })

            let value = basket?.productsQuantity == nil ? nil : "\(basket!.productsQuantity)"
            basketItem?.badgeValue = value
        }
    }
}

// MARK: - Extensions

extension BasketPresenter: BasketPresenterProtocol {
    
    // MARK: - Functions
    
    func onViewWillAppear() {
        view.setDisabledWhileSending(at: nil)
        fetchBasket()
    }
    
    func placeOrderButtonDidTap() {
        // TODO: add a call to the coordinator method to go to the screen for filling in the data for the purchase
        view.setDisabledWhileSending(at: nil)
        payBasket()
    }
    
    func productQuantityDidChange(_ product: BasketCellModel, quantity: Int, index: Int) {
        guard let updateProduct = BasketCellModelFactory.construct(from: product, with: quantity) else { return }
        
        view.setDisabledWhileSending(at: index)
        
        if quantity == 0 {
            removeProduct(updateProduct)
        } else {
            editProduct(updateProduct)
        }
    }
    
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }
        
        imageDownloader.getImage(fromUrl: url) { (image, _) in
            completion(image)
        }
    }
}
