//
//  Review.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Foundation

/// The review data model for server response decoding
struct Review: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "review_id"
        case productId = "product_id"
        case userId = "user_id"
        case rating
        case date
        case body
    }

    // MARK: - Properties

    let id: Int
    let productId: Int
    let userId: Int?
    let rating: Int
    let date: TimeInterval
    let body: String
}
