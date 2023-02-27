//
//  RemoveReviewRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

protocol RemoveReviewRequestFactory {

    // MARK: - Functions

    func removeReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
