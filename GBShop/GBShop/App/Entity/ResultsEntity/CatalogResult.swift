//
//  CatalogResult.swift
//  GBShop
//
//  Created by Artem Mayer on 19.02.2023.
//

import Foundation

/// The data model of the server's response to a request to get a product catalog.
struct CatalogResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case pageNumber = "page_number"
        case products
    }

    // MARK: - Properties

    let result: Int
    let pageNumber: Int?
    let products: [Product]?
}
