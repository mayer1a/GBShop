//
//  ReviewsResult.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Foundation

// MARK: - ReviewsResult

struct ReviewsResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case reviews
    }

    // MARK: - Properties

    let result: Int
    let reviews: [Review]?
}
