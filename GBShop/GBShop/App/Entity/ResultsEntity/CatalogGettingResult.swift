//
//  CatalogGettingResult.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Foundation

struct CatalogGettingResult: Codable {
    let pageNumber: Int
    let products: [Product]
}
