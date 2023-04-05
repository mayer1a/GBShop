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

        let userId: Int
        let basketElement: BasketElement

        var parameters: Parameters? {
            [
                "user_id": userId,
                "basket_element": basketElementsParameters
            ]
        }

        // MARK: - Private properties

        private var basketElementsParameters: Parameters {
            [
                "product": productParameters,
                "quantity": basketElement.quantity
            ]
        }

        private var productParameters: Parameters {
            [
                "product_id": basketElement.product.id,
                "product_name": basketElement.product.name,
                "product_category": basketElement.product.category,
                "product_price": basketElement.product.price,
                "product_main_image": basketElement.product.mainImage
            ]
        }
    }

    // MARK: - EditProduct

    struct EditProduct: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "edit-product"

        let userId: Int
        let basketElement: BasketElement

        var parameters: Parameters? {
            [
                "user_id": userId,
                "basket_element": basketElementsParameters
            ]
        }

        // MARK: - Private properties

        private var basketElementsParameters: Parameters {
            [
                "product": productParameters,
                "quantity": basketElement.quantity
            ]
        }

        private var productParameters: Parameters {
            [
                "product_id": basketElement.product.id,
                "product_name": basketElement.product.name,
                "product_category": basketElement.product.category,
                "product_price": basketElement.product.price,
                "product_main_image": basketElement.product.mainImage
            ]
        }
    }

    // MARK: - RemoveProduct

    struct RemoveProduct: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "remove-product"

        let userId: Int
        let productId: Int

        var parameters: Parameters? {
            [
                "user_id": userId,
                "product_id": productId
            ]
        }
    }

    // MARK: - GetBasket

    struct GetBasket: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket"

        let userId: Int

        var parameters: Parameters? {
            ["user_id": userId]
        }
    }

    // MARK: - PayBasket

    struct PayBasket: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "pay-basket"

        let userId: Int

        var parameters: Parameters? {
            ["user_id": userId]
        }
    }
}
