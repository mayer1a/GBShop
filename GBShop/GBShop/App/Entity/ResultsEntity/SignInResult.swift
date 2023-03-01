//
//  SignInResult.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

struct SignInResult: Codable {

    // MARK: - Properties
    
    let result: Int
    let user: User
}
