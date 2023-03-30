//
//  BasketModel.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

// MARK: - BasketCellModel

struct BasketCellModel {
    let productId: Int
    let productName: String
    let productPrice: String
    let quantity: String
}

// MARK: - BasketModel

struct BasketModel {
    let amount: String
    let productQuantity: Int
    let cellModels: [BasketCellModel]
}
