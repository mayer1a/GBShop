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
        case id = "id_product"
        case productName = "product_name"
        case price
    }

    // MARK: - Properties

    let result: Int
    let id: Int
    let productName: String
    let price: Int
}
