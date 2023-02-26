//
//  Review.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Foundation

struct Review: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "review_id"
        case productId = "product_id"
        case userId = "user_id"
        case description
    }

    // MARK: - Properties

    let id: Int
    let productId: Int
    let userId: Int?
    let description: String
}
