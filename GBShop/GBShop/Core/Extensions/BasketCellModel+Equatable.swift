//
//  BasketCellModel+Equatable.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import Foundation

extension BasketCellModel: Equatable {

    // MARK: - Functions

    static func ==(lhs: BasketCellModel, rhs: BasketCellModel) -> Bool {
        lhs.productId == rhs.productId && lhs.quantity == rhs.quantity
    }
}
