//
//  ApproveReviewRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

protocol ApproveReviewRequestFactory {

    // MARK: - Functions

    func approveReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)
}

