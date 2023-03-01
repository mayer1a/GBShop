//
//  Reviews+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

extension Reviews {

    // MARK: - Reviews

    struct Reviews: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "reviews"

        let productId: Int
        let pageNumber: Int

        var parameters: Parameters? {
            return [
                "product_id": productId,
                "page_number": pageNumber
            ]
        }
    }

    // MARK: - AddReview

    struct AddReview: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "add-review"

        let userId: Int?
        let productId: Int
        let description: String

        var parameters: Parameters? {
            guard let userId = userId else {
                return [
                    "product_id": productId,
                    "description": description]
            }

            return [
                "user_id": userId,
                "product_id": productId,
                "description": description
            ]
        }
    }

    // MARK: - ApproveReview

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

    // MARK: - RemoveReview

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
