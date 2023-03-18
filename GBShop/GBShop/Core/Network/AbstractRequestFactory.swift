//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire


/// Abstract request factory contract.
///
/// The ``baseUrl`` property returns the base address of the server.
///
/// The ``request(request:completionHandler:)-9tu8m``  generic method returns a basic query of type **DataRequest**
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

    // MARK: - Properties

    var baseUrl: URL {
        return URL(string: "https://gbshop-efcs.onrender.com/")!
    }

    // MARK: - Functions

    /// Default implementation of the request creation generic method
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
