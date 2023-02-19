//
//  RegistrationResult.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Foundation

struct RegistrationResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }

    // MARK: - Properties

    let result: Int
    let userMessage: String
}
