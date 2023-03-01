//
//  Basket+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

// MARK: - Extensions

extension Basket {

    // MARK: - AddProduct

    struct AddProduct: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "add-product"

        let productId: Int
        let quantity: Int

        var parameters: Parameters? {
            return [
                "product_id": productId,
                "quantity": quantity
            ]
        }
    }

    // MARK: - RemoveProduct

    struct RemoveProduct: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "remove-product"

        let productId: Int

        var parameters: Parameters? {
            return [
                "product_id": productId
            ]
        }
    }

    // MARK: - PayBasket

    struct PayBasket: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "pay-basket"

        let productId: Int
        let quantity: Int

        var parameters: Parameters? {
            nil
        }
    }
}
