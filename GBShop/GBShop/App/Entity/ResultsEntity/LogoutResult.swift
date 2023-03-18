//
//  LogoutResult.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Foundation

/// The data model of the server's response to the logout request.
struct LogoutResult: Codable {

    // MARK: - Properties

    let result: Int
}
