//
//  User.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

/// The user data model containing complete information about the user.
struct User: Codable {

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username
        case name
        case lastname
        case email
        case creditCard = "credit_card"
        case gender
        case bio
    }

    // MARK: - Properties

    let id: Int
    let username: String
    let name: String
    let email: String
    let creditCard: String
    let lastname: String
    let gender: Gender
    let bio: String
}
