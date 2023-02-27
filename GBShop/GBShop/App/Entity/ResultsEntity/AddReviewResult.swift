//
//  AddReviewResult.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Foundation

// MARK: - ReviewsResult

struct AddReviewResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }

    // MARK: - Properties

    let result: Int
    let userMessage: String?
}
