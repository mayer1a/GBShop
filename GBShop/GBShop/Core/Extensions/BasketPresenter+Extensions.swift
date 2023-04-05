//
//  BasketPresenter+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import Foundation

extension BasketPresenter {

    // MARK: - Functions

    func getIndexes(for newModel: BasketModel, with oldModel: BasketModel?) -> [IndexPath] {
        guard let oldModel else {
            return []
        }

        if newModel.productsQuantity > oldModel.productsQuantity {
            return calculateIndexes(smaller: oldModel, newModel)
        } else {
            return calculateIndexes(smaller: newModel, oldModel)
        }
    }

    // MARK: - Private functions
    
    private func calculateIndexes(smaller smallerModel: BasketModel, _ model: BasketModel) -> [IndexPath] {
        let isSizeEqual = smallerModel.productsQuantity == model.productsQuantity
        var indexes = smallerModel.cellModels.enumerated().compactMap { smallerCellModel -> IndexPath? in
            guard smallerCellModel.element != model.cellModels[smallerCellModel.offset] else { return nil }
            return IndexPath(row: smallerCellModel.offset, section: 0)
        }

        if !isSizeEqual {
            let additionals = (smallerModel.productsQuantity..<model.productsQuantity).compactMap {
                IndexPath(row: $0, section: 0)
            }
            
            indexes.append(contentsOf: additionals)
        }

        return indexes
    }
}
