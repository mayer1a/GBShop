//
//  RemoveProductResult.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

/// The data model of the server's response to a request to remove an item from the user's basket.
struct RemoveProductResult: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }

    // MARK: - Properties

    let result: Int
    let errorMessage: String?
}
