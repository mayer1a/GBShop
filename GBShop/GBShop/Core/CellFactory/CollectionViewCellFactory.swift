//
//  CollectionViewCellFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 25.03.2023.
//

import UIKit

final class CollectionViewCellFactory {

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
