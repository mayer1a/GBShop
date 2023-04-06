//
//  CollectionViewCellFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import UIKit

/// The factory creates a ``ProductCell`` product cell view for ``UICollectionView`` with ``IndexPath``
/// based on the position of the future cell - left column or right column, changing the indentation of the headings
struct CollectionViewCellFactory {

    // MARK: - Functions

    static func createCell(for collectionView: UICollectionView, indexPath: IndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellIdentifier, for: indexPath)

        guard let cell = cell as? ProductCell else { return .init() }

        if indexPath.item % 2 == 0 {
            cell.setupLeftCellConstraints()
        } else {
            cell.setupRightCellConstraints()
        }

        return cell
    }
}
