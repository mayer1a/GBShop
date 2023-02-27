//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Alamofire

protocol ReviewsRequestFactory {

    // MARK: - Functions

    func getReviews(
        productId: Int,
        pageNumber: Int,
        completionHandler: @escaping (AFDataResponse<ReviewsResult>) -> Void)
}
