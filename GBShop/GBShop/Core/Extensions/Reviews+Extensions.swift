//
//  Reviews+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

extension Reviews {

    // MARK: - Reviews

    /// The structure of the request model for getting reviews for a specific product, used in the ``ReviewsRequestFactory``
    struct Reviews: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "reviews"

        let productId: Int
        let pageNumber: Int

        var parameters: Parameters? {
            [
                "product_id": productId,
                "page_number": pageNumber
            ]
        }
    }

    // MARK: - AddReview

    /// The structure of the request model for adding a review for a specific product, used in the ``ReviewsRequestFactory``
    struct AddReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "add-review"

        let userId: Int?
        let productId: Int
        let body: String
        let rating: Int
        let date: TimeInterval

        var parameters: Parameters? {
            var parameters: Parameters = [
                "product_id": productId,
                "body": body,
                "rating": rating,
                "date": date
            ]

            parameters.merge(optionalParameters, uniquingKeysWith: { (_, value) in value })
            return parameters
        }

        // MARK: - Private properties

        private var optionalParameters: Parameters {
            guard let userId else { return [:] }

            return ["user_id": userId]
        }
    }

    // MARK: - ApproveReview

    /// The structure of the request model for approving a review for a specific review ID, used in the ``ReviewsRequestFactory``
    struct ApproveReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "approve-review"

        let userId: Int
        let reviewId: Int

        var parameters: Parameters? {
            [
                "user_id": userId,
                "review_id": reviewId
            ]
        }
    }

    // MARK: - RemoveReview

    /// The structure of the request model for removing a review for a specific review ID, used in the ``ReviewsRequestFactory``
    struct RemoveReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "remove-review"

        let userId: Int
        let reviewId: Int

        var parameters: Parameters? {
            [
                "user_id": userId,
                "review_id": reviewId
            ]
        }
    }
    
}
