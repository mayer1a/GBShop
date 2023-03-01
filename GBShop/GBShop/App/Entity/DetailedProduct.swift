//
//  DetailedProduct.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

struct DetailedProduct: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case description = "product_description"
    }

    // MARK: - Properties

    let description: String
}
