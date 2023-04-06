//
//  Reviews.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

/// `Reviews` implements sending requests related to feedback actions to the server.
final class Reviews: AbstractRequestFactory {

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

// MARK: - ReviewsRequestFactory

extension Reviews: ReviewsRequestFactory {

    // MARK: - Functions

    func getReviews(
        productId: Int,
        pageNumber: Int,
        completionHandler: @escaping (AFDataResponse<ReviewsResult>) -> Void
    ) {
        let requestModel = Reviews(
            baseUrl: self.baseUrl,
            productId: productId,
            pageNumber: pageNumber)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func addReview(
        userId: Int?,
        productId: Int,
        body: String,
        rating: Int,
        date: TimeInterval,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void
    ) {
        let requestModel = AddReview(
            baseUrl: self.baseUrl,
            userId: userId,
            productId: productId,
            body: body,
            rating: rating,
            date: date)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

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
