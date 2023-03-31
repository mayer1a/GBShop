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
            amount: "\(basketModel.amount) ₽",
            productsQuantity: basketModel.productsQuantity,
            cellModels: cellModels)
    }

    static func construct(from basketModel: BasketCellModel) -> BasketElement? {
        guard let price = Int(basketModel.price) else { return nil }
        let product = Product(
            id: basketModel.productId,
            name: basketModel.name,
            category: basketModel.category,
            price: price,
            mainImage: basketModel.imageUrl)

        return BasketElement(product: product, quantity: basketModel.quantity)
    }

    static func construct(from basketModel: BasketCellModel, with quantity: Int) -> BasketElement? {
        guard let price = Int(basketModel.price.trimmingCharacters(in: ["₽", " "])) else { return nil }
        
        let product = Product(
            id: basketModel.productId,
            name: basketModel.name,
            category: basketModel.category,
            price: price,
            mainImage: basketModel.imageUrl)

        return BasketElement(product: product, quantity: quantity)
    }

    static func construct(from product: Product, with quantity: Int) -> BasketElement {
        BasketElement(product: product, quantity: quantity)
    }

    // MARK: - Private functions

    private static func construct(from basketElementModel: BasketElement) -> BasketCellModel {
        BasketCellModel(
            productId: basketElementModel.product.id,
            category: basketElementModel.product.category,
            name: basketElementModel.product.name,
            price: "\(basketElementModel.product.price * basketElementModel.quantity) ₽",
            quantity: basketElementModel.quantity,
            imageUrl: basketElementModel.product.mainImage)
    }
}
