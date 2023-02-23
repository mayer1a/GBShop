//
//  ProductResult.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Foundation

struct ProductDetailed: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case price = "product_price"
        case name = "product_name"
        case description = "product_description"
    }

    // MARK: - Properties

    let price: Int
    let name: String
    let description: String
}

struct ProductResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case product
    }

    // MARK: - Properties

    let result: Int
    let product: ProductDetailed
}
