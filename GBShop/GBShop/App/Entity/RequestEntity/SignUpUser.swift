//
//  SignUpUser.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

/// The data model of the `SignUpModule` for sending a request to the server.
struct SignUpUser: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case name
        case lastname
        case username
        case password
        case email
        case creditCard = "credit_card"
        case gender
        case bio
    }

    // MARK: - Properties

    let name: String
    let lastname: String
    let username: String
    let password: String
    let email: String
    let creditCard: String
    let gender: Gender.RawValue
    let bio: String
}
