//
//  ProductGetting.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

class ProductGetting: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
//    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

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

extension ProductGetting {

    // MARK: - RequestRouter

    struct ProductGetting: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "product"

        let productId: Int

        var parameters: Parameters? {
            return [
                "product_id": productId,
            ]
        }
    }
}

extension ProductGetting: ProductGettingRequestFactory {

    // MARK: - Functions

    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void
    ) {
        let requestModel = ProductGetting(baseUrl: self.baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

