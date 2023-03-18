//
//  EditProfileResult.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Foundation

/// The data model of the server's response to a request to edit user profile data.
struct EditProfileResult: Codable {

    // MARK: - CodignKeys

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }

    // MARK: - Properties

    let result: Int
    let errorMessage: String?
}
