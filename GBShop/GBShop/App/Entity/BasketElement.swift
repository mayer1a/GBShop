//
//  BasketElement.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

// MARK: - BasketElement

/// The data model of the `BasketElement` for sending a request to the server.
struct BasketElement: Codable {

    // MARK: - Properties

    let product: Product
    let quantity: Int
}
