//
//  Product.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Foundation

struct Product: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case productName = "product_name"
        case price
    }

    // MARK: - Properties

    let id: Int
    let productName: String
    let price: Int
}
