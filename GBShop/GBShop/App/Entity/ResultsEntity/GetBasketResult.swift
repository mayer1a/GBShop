//
//  GetBasketResult.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

/// The data model of the server's response to a request to get a user's basket.
struct GetBasketResult: Codable {

    // MARK: - CodignKeys

    enum CodingKeys: String, CodingKey {
        case result
        case basket
        case errorMessage = "error_message"
    }

    // MARK: - Properties

    let result: Int
    let basket: UserBasket?
    let errorMessage: String?
}
