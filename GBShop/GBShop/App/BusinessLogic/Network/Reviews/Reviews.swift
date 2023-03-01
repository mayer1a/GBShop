//
//  Reviews.swift
//  GBShop
//
//  Created by Artem Mayer on 26.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class Reviews: AbstractRequestFactory {

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

extension Reviews {

    // MARK: - RequestRouter

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

}
