//
//  BasketPresenter+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 31.03.2023.
//

import Foundation

extension BasketPresenter {

    // MARK: - Functions

    /// Calculates indexes of changes in the basket based on the changed basket received from the server and the current basket displayed in the table
    ///
    /// - Parameters:
    ///   - newModel: Changed basket received from server of type ``BasketModel``
    ///   - oldModel: Current basketdisplayed in the table of type ``BasketModel``
    /// - Returns:
    ///     An array of the non-nil results with ``IndexPath`` elements type.
    func getIndexes(for newModel: BasketModel, with oldModel: BasketModel?) -> [IndexPath] {
        guard let oldModel else {
            return []
        }

        if newModel.cellModels.count > oldModel.cellModels.count {
            return calculateIndexes(smaller: oldModel, newModel)
        } else {
            return calculateIndexes(smaller: newModel, oldModel)
        }
    }

    // MARK: - Private functions

    private func calculateIndexes(smaller smallerModel: BasketModel, _ model: BasketModel) -> [IndexPath] {
        let shouldAddIndexes = smallerModel.cellModels.count > model.cellModels.count
        var indexes = smallerModel.cellModels.enumerated().compactMap { smallerCellModel -> IndexPath? in
            guard smallerCellModel.element != model.cellModels[smallerCellModel.offset] else { return nil }
            return IndexPath(row: smallerCellModel.offset, section: 0)
        }

        if shouldAddIndexes {
            let additionals = (smallerModel.cellModels.count..<model.cellModels.count).compactMap {
                IndexPath(row: $0, section: 0)
            }

            indexes.append(contentsOf: additionals)
        }

        return indexes
    }
}
