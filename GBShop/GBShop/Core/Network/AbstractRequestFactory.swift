//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

protocol AbstractRequestFactory {

    // MARK: - Properties

    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }

    // MARK: - Functions

    @discardableResult func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> DataRequest
}

// MARK: - Extensions

extension AbstractRequestFactory {

    // MARK: - Functions

    @discardableResult public func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> DataRequest {
        let request = sessionManager
            .request(request)
            .responseCodable(
                errorParser: errorParser,
                queue: queue,
                completionHandler: completionHandler)

        return request
    }
}
