//
//  ProductResult.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Foundation

/// The data model of the server's response to a request to get a specific product.
struct ProductResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case product
    }

    // MARK: - Properties

    let result: Int
    let product: DetailedProduct?
}
