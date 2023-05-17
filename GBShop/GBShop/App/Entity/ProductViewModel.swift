//
//  ProductViewModel.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import Foundation

/// The model for representation ``DetailedProduct`` model to product cell view model for ``ProductViewController``
struct ProductViewModel {

    // MARK: - Properties
    
    let category: String
    let name: String
    let price: String
    let description: String
}
