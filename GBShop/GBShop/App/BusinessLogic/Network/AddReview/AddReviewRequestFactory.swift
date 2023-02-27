//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

protocol AddReviewRequestFactory {

    // MARK: - Functions

    func addReview(
        userId: Int?,
        productId: Int,
        description: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}
