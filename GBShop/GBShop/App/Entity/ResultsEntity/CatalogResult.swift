//
//  CatalogResult.swift
//  GBShop
//
//  Created by Artem Mayer on 19.02.2023.
//

import Foundation

// MARK: - Product

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

// MARK: - CatalogResult

struct CatalogResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case pageNumber = "page_number"
        case products
    }

    // MARK: - Properties

    let result: Int
    let pageNumber: Int
    let products: [Product]
}
