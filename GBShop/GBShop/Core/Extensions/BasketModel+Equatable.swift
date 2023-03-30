//
//  BasketModel+Equatable.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import Foundation

extension BasketModel: Equatable {

    // MARK: - Functions

    static func ==(_ lhs: BasketModel, _ rhs: BasketModel) -> Bool {
        lhs.cellModels == rhs.cellModels
    }
}