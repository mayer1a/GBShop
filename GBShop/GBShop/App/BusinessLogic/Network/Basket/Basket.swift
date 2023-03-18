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
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddProductResult>) -> Void
    ) {
        let requestModel = AddProduct(baseUrl: baseUrl, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func removeProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveProductResult>) -> Void
    ) {
        let requestModel = RemoveProduct(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func payBasket(completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
