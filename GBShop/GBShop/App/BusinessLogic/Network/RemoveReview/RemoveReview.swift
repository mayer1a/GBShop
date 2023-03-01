//
//  RemoveReview.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class RemoveReview: AbstractRequestFactory {

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

extension RemoveReview {

    // MARK: - RequestRouter

    struct RemoveReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "remove-review"

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

// MARK: - RemoveReviewRequestFactory

extension RemoveReview: RemoveReviewRequestFactory {

    // MARK: - Functions

    func removeReview(
        userId: Int,
        reviewId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void
    ) {
        let requestModel = RemoveReview(
            baseUrl: self.baseUrl,
            userId: userId,
            reviewId: reviewId)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
