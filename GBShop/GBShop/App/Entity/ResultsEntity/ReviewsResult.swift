//
//  ReviewsResult.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Foundation

/// The data model of the server's response to a request to get a list of reviews.
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
