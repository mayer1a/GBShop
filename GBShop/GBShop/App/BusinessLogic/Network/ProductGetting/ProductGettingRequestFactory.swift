//
//  ProductGettingRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

protocol ProductGettingRequestFactory {

    // MARK: - Functions

    func getProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
