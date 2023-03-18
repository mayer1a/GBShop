//
//  AddProductResult.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

/// The data model of the server's response to a request to add an item to the user's basket.
struct AddProductResult: Codable {

    // MARK: - Properties

    let result: Int
}
