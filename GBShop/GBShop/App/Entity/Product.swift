//
//  Product.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

/// The product data model for displaying the catalog.
struct Product: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case category = "product_category"
        case price = "product_price"
        case mainImage = "product_main_image"
    }

    // MARK: - Properties

    let id: Int
    let name: String
    let category: String
    let price: Int
    let mainImage: String
}
