//
//  RemoveReviewResult.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Foundation

/// The data model of the server's response to a request to remove a specific review.
struct RemoveReviewResult: Codable {
    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }

    // MARK: - Properties

    let result: Int
    let errorMessage: String?
}
