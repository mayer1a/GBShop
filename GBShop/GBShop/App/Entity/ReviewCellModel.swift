//
//  ReviewCellModel.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import Foundation

/// The model for representation ``Review`` model to product cell view model for ``ReviewsViewController``
struct ReviewCellModel {

    // MARK: - Properties
    
    let userId: String
    let body: String
    let reviewStars: Int
    let date: String
}
