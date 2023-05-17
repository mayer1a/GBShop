//
//  UserBasket.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

/// The basket data model for server response decoding which contains collection of ``BasketElement``
struct UserBasket: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case amount
        case productsQuantity = "products_quantity"
        case products
    }

    // MARK: - Properties

    let amount: Int
    let productsQuantity: Int
    let products: [BasketElement]
}
