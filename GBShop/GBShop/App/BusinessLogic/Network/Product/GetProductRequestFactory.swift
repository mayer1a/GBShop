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

    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
