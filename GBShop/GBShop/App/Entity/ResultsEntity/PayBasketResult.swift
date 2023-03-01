//
//  PayBasketResult.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

// MARK: - PayBasketResult

struct PayBasketResult: Codable {

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }

    // MARK: - Properties

    let result: Int
    let userMessage: String?
}
