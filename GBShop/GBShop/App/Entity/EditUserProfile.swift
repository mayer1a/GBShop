//
//  Profile.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

// MARK: - User

struct EditUserProfile: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username
        case password
        case email
        case creditCard = "credit_card"
        case gender
        case bio
    }

    // MARK: - Properties

    let id: Int
    let username: String
    let password: String
    let email: String
    let creditCard: String
    let gender: Gender
    let bio: String
}
