//
//  BasketCellModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import Foundation

/// Factory creating basket data models
///
/// For example:
/// ```
/// static func construct(from basketModel: UserBasket) -> BasketModel
/// ```
/// creates a `BasketCellModel` models from a server basket `UserBasket` data model
struct BasketCellModelFactory {

    // MARK: - Functions

    static func construct(from basketModel: UserBasket) -> BasketModel {
        let cellModels = basketModel.products.compactMap { basketElement -> BasketCellModel in
            construct(from: basketElement)
        }

        return BasketModel(
            amount: "\(basketModel.amount)",
            productsQuantity: basketModel.productsQuantity,
            cellModels: cellModels)
    }

    // MARK: - Private functions

    private static func construct(from basketElementModel: BasketElement) -> BasketCellModel {
        BasketCellModel(
            productId: basketElementModel.product.id,
            category: basketElementModel.product.category,
            name: basketElementModel.product.name,
            price: "\(basketElementModel.product.price * basketElementModel.quantity)",
            quantity: basketElementModel.quantity)
    }
}
