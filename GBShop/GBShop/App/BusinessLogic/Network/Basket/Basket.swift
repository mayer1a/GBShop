//
//  Basket.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

/// `Basket` implements sending requests related to the user's shopping cart to the server
final class Basket: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

    // MARK: - Constructions

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }

}

// MARK: - BasketRequestFactory

extension Basket: BasketRequestFactory {

    // MARK: - Functions

    func addProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFDataResponse<AddProductResult>) -> Void
    ) {
        let requestModel = AddProduct(baseUrl: baseUrl, userId: userId, basketElement: basketElement)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func editProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFDataResponse<EditProductResult>) -> Void
    ) {
        let requestModel = EditProduct(baseUrl: baseUrl, userId: userId, basketElement: basketElement)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func removeProduct(
        userId: Int,
        productId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveProductResult>) -> Void
    ) {
        let requestModel = RemoveProduct(baseUrl: baseUrl, userId: userId, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
