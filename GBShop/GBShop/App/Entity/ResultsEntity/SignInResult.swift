//
//  SignInResult.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

/// The data model of the server's response to a user authorization request.
struct SignInResult: Codable {

    // MARK: - CodignKeys

    enum CodingKeys: String, CodingKey {
        case result
        case user
        case errorMessage = "error_message"
    }

    // MARK: - Properties
    
    let result: Int
    let user: User?
    let errorMessage: String?
}
