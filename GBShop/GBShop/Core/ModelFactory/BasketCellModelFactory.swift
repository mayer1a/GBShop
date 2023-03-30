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
/// func construct(from signUpModel: UserBasket) -> [BasketCellModel]
/// ```
/// creates a `BasketCellModel` models from a server basket `UserBasket` data model
struct BasketCellModelFactory {

    // MARK: - Functions

    func construct(from basketModel: UserBasket) -> BasketModel {
        let cellModels = basketModel.products.compactMap { basketElement -> BasketCellModel in
            construct(from: basketElement)
        }

        return BasketModel(
            amount: "\(basketModel.amount)",
            productQuantity: basketModel.productsQuantity,
            cellModels: cellModels)
    }

    // MARK: - Private functions
    
    private func construct(from basketElementModel: BasketElement) -> BasketCellModel {
        BasketCellModel(
            productId: basketElementModel.product.id,
            productName: basketElementModel.product.name,
            productPrice: "\(basketElementModel.product.price)",
            quantity: "\(basketElementModel.quantity)")
    }
}
