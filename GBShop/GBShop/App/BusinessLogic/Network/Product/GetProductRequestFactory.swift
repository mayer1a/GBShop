//
//  ProductGettingRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

/// Server request factory contract to receive product
protocol GetProductRequestFactory {

    // MARK: - Functions

    /// Get a product for a specific product identifier
    /// - Parameters:
    ///   - productId: Product ID for which you want to get detailed information.
    ///   - completionHandler: Received response from the server.
    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
