//
//  ProductCellModel.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import Foundation

/// The model for representation ``Product`` model to product cell view model for ``CatalogViewController``
struct ProductCellModel {

    // MARK: - Properties

    let id: String
    let name: String
    let category: String
    let price: String
    let imageUrl: String
}
