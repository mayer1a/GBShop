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
    let category: String
    let name: String
    let price: String
    let quantity: Int
    let imageUrl: String
}

// MARK: - BasketModel

struct BasketModel {
    let amount: String
    let productsQuantity: Int
    let cellModels: [BasketCellModel]
}
