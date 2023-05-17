//
//  GetCatalogRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

/// Server request factory contract to get product catalog
protocol CatalogRequestFactory {

    // MARK: - Functions

    /// Get a list of products for a specific number of page and category identifier
    /// - Parameters:
    ///   - pageNumber: Page number for which you want to get products for.
    ///   - categoryId: Category ID for which you want to to get reviews for.
    ///   - completionHandler: Received response from the server.
    func getCatalog(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
}
