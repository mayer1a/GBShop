//
//  GetProduct.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

/// `GetProduct` implements sending requests related to receiving goods to the server.
final class GetProduct: AbstractRequestFactory {

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

// MARK: - Extensions

extension GetProduct {

    // MARK: - RequestRouter

    struct GetProduct: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "product"

        let productId: Int

        var parameters: Parameters? {
            return [
                "product_id": productId,
            ]
        }
    }
}

// MARK: - GetProductRequestFactory

extension GetProduct: GetProductRequestFactory {

    // MARK: - Functions

    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void
    ) {
        let requestModel = GetProduct(baseUrl: self.baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

