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

    func addReview(
        userId: Int?,
        productId: Int,
        description: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)

    func approveReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)

    func removeReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
