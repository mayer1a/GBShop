//
//  ProductCellModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import Foundation

struct ProductCellModelFactory {

    // MARK: - Functions

    static func construct(from product: Product) -> ProductCellModel {
        ProductCellModel(
            id: "\(product.id)",
            name: product.name,
            category: "",
            price: "\(product.price) ₽",
            imageUrl: "")
    }
}
