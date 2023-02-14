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
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }

    // MARK: - Properties

    let id: Int
    let login: String
    let name: String
    let lastname: String

}
