//
//  User.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

struct User: Codable {

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username
        case name
        case lastname
    }

    // MARK: - Properties

    let id: Int
    let username: String
    let name: String
    let lastname: String

}
