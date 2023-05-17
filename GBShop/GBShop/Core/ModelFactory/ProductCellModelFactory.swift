//
//  ProductCellModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import Foundation

/// Factory creating product cell view model ``ProductCellModel`` from ``Product`` model
/// for catalog screen ``CatalogViewController``
struct ProductCellModelFactory {

    // MARK: - Functions

    static func construct(from product: Product) -> ProductCellModel {
        ProductCellModel(
            id: "\(product.id)",
            name: product.name,
            category: product.category,
            price: "\(product.price) ₽",
            imageUrl: product.mainImage)
    }
}
