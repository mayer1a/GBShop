//
//  Profile.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

// MARK: - User

struct EditProfile: Codable {

    init(
        userId: Int,
        name: String,
        lastname: String,
        username: String,
        oldPassword: String? = nil,
        newPassword: String? = nil,
        email: String,
        creditCard: String,
        gender: Gender.RawValue,
        bio: String
    ) {
        self.userId = userId
        self.name = name
        self.lastname = lastname
        self.username = username
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.email = email
        self.creditCard = creditCard
        self.gender = gender
        self.bio = bio
    }
    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case lastname
        case username
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case email
        case creditCard = "credit_card"
        case gender
        case bio
    }

    // MARK: - Properties

    let userId: Int
    let name: String
    let lastname: String
    let username: String
    let oldPassword: String?
    let newPassword: String?
    let email: String
    let creditCard: String
    let gender: Gender.RawValue
    let bio: String
}
