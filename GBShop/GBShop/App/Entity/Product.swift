//
//  Product.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

struct Product: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case price = "product_price"
    }

    // MARK: - Properties

    let id: Int
    let name: String
    let price: Int
}
