//
//  AddReview.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class AddReview: AbstractRequestFactory {

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

extension AddReview {

    // MARK: - RequestRouter

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
}

// MARK: - AddReviewRequestFactory

extension AddReview: AddReviewRequestFactory {

    // MARK: - Functions

    func addReview(
        userId: Int?,
        productId: Int,
        description: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void
    ) {
        let requestModel = AddReview(
            baseUrl: self.baseUrl,
            userId: userId,
            productId: productId,
            description: description)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
