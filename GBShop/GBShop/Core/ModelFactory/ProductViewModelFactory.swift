//
//  ProductViewModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import Foundation

/// Factory creating product view model ``ProductViewModel`` from ``Product`` and ``DetailedProduct`` models
/// for detailed product screen ``ProductViewController``
struct ProductViewModelFactory {

    // MARK: - Functions

    static func construct(from product: Product, with detailed: DetailedProduct) -> ProductViewModel {
        ProductViewModel(
            category: product.category,
            name: product.name,
            price: "\(product.price) ₽",
            description: detailed.description)
    }
}
