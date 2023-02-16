//
//  LoginResult.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

struct LoginResult: Codable {

    // MARK: - Properties
    
    let result: Int
    let user: User
}
