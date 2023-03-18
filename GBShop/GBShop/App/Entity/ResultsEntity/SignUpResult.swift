//
//  SignUpResult.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Foundation

/// The data model of the server's response to a user registration request.
struct SignUpResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case userId = "user_id"
        case userMessage = "user_message"
    }

    // MARK: - Properties

    let result: Int
    let userId: Int?
    let userMessage: String
}
