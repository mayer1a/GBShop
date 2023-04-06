//
//  BasketModel.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

// MARK: - BasketCellModel

/// The model for representation ``UserBasket`` model to basket cell view model for ``BasketViewController``
struct BasketCellModel {
    let productId: Int
    let category: String
    let name: String
    let price: String
    let quantity: Int
    let imageUrl: String
}

// MARK: - BasketModel

/// The model for representation ``UserBasket`` model to basket view model for ``BasketViewController``
/// which contains cell view models ``BasketCellModel`` collection
struct BasketModel {
    let amount: String
    let productsQuantity: Int
    let cellModels: [BasketCellModel]
}
