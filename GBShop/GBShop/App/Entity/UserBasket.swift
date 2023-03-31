//
//  UserBasket.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

// MARK: - UserBasket

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
