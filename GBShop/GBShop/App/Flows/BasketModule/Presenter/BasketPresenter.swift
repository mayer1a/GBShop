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
    func insertProductRows(at indexes: [Int], basket: BasketModel)
    func updateProductRows(at indexes: [Int], basket: BasketModel)
    func deleteProductRows(at indexes: [Int], basket: BasketModel)
    func basketDidPay()
}

protocol BasketPresenterProtocol: AnyObject {
    init(
        view: BasketViewProtocol,
        requestFactory: BasketRequestFactory,
        coordinator: BasketBaseCoordinator,
        userId: Int)

    func onViewWillAppear()
    func placeOrderButtonDidTap()
    func productQuantityDidChange(_ product: BasketElement)
}

// MARK: - BasketPresenter

final class BasketPresenter {

    // MARK: - Private properties

    private weak var view: BasketViewProtocol!
    private let coordinator: BasketBaseCoordinator
    private let requestFactory: BasketRequestFactory
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

    // MARK: - Private functions

    private func handleResult(result: GetBasketResult, _ action: ([Int], BasketModel) -> Void) {
        guard result.result != 0, let basket = result.basket else {
            view.showFailure(with: result.errorMessage)
            return
        }

        let userBasket = BasketCellModelFactory.construct(from: basket)
        let indexes = getIndexes(for: userBasket, with: self.basket)
        self.basket = userBasket

        action(indexes, userBasket)
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
            view.basketDidFetch(basketModel)
        case .failure(_):
            self.view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func handleAddProductResponse(_ response: AFBasketResult) {
        switch response.result {
        case .success(let basketResult):
            handleResult(result: basketResult, view.insertProductRows)
        case .failure(_):
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func handleEditProductResponse(_ response: AFBasketResult) {
        switch response.result {
        case .success(let basketResult):
            handleResult(result: basketResult, view.updateProductRows)
        case .failure(_):
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func handleRemoveProductResponse(_ response: AFBasketResult) {
        switch response.result {
        case .success(let basketResult):
            handleResult(result: basketResult, view.deleteProductRows)
        case .failure(_):
            view.showFailure(with: "Ошибка сервера. Повторите попытку позже.")
        }
    }

    private func handlePayBasketResponse(_ response: AFPayBasketResult) {
        switch response.result {
        case .success(let basketResult):
            if basketResult.result == 0 {
                view.showFailure(with: basketResult.errorMessage)
                return
            }

            basket = nil
            view.basketDidPay()
        case .failure(_):
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

    private func addProduct(_ product: BasketElement) {
        requestFactory.addProduct(userId: userId, basketElement: product) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.handleAddProductResponse(response)
            }
        }
    }

    private func editProduct(_ product: BasketElement) {
        requestFactory.editProduct(userId: userId, basketElement: product) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.handleEditProductResponse(response)
            }
        }
    }

    private func removeProduct(_ product: BasketElement) {
        requestFactory.removeProduct(userId: userId, productId: product.product.id) { [weak self] response in
            guard let self else { return }

            DispatchQueue.main.async {
                self.handleRemoveProductResponse(response)
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
}

// MARK: - Extensions

extension BasketPresenter: BasketPresenterProtocol {

    // MARK: - Functions

    func onViewWillAppear() {
        fetchBasket()
    }

    func placeOrderButtonDidTap() {
        // TODO: add a call to the coordinator method to go to the screen for filling in the data for the purchase
        payBasket()
    }

    func productQuantityDidChange(_ product: BasketElement) {
        editProduct(product)
    }
}
