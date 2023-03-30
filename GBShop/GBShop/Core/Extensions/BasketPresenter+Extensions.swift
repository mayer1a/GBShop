//
//  BasketPresenter+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import Foundation

extension BasketPresenter {

    // MARK: - Functions

    func getIndexes(for newModel: BasketModel, with oldModel: BasketModel?) -> [Int] {
        guard let oldModel else {
            return []
        }

        if newModel.productsQuantity > oldModel.productsQuantity {
            return calculateIndexes(smaller: oldModel, newModel)
        } else {
            return calculateIndexes(smaller: newModel, oldModel)
        }
    }

    private func calculateIndexes(smaller smallerModel: BasketModel, _ model: BasketModel) -> [Int] {
        let isSizeEqual = smallerModel.productsQuantity == model.productsQuantity
        var indexes = smallerModel.cellModels.enumerated().compactMap { smallerCellModel -> Int? in
            guard smallerCellModel.element != model.cellModels[smallerCellModel.offset] else { return nil }
            return smallerCellModel.offset
        }

        if !isSizeEqual {
            let additionals = (smallerModel.productsQuantity..<model.productsQuantity).compactMap { $0 }
            indexes.append(contentsOf: additionals)
        }

        return indexes
    }
}
