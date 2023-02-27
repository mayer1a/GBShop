//
//  ApproveReview.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

class ApproveReview: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

    // MARK: - Constructions

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

// MARK: - Extensions

extension ApproveReview {

    // MARK: - RequestRouter

    struct ApproveReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "approve-review"

        let userId: Int
        let reviewId: Int

        var parameters: Parameters? {
            return [
                "user_id": userId,
                "review_id": reviewId
            ]
        }
    }
}

extension ApproveReview: ApproveReviewRequestFactory {

    // MARK: - Functions

    func approveReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void
    ) {
        let requestModel = ApproveReview(
            baseUrl: self.baseUrl,
            userId: userId,
            reviewId: reviewId)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
