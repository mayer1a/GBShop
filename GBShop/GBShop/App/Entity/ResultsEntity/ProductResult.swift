//
//  ProductResult.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Foundation

struct ProductResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }

    // MARK: - Properties

    let result: Int
    let name: String
    let price: Int
    let description: String
}
