//
//  DataRequest.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

// MARK: - DataResponseSerializerProtocol

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {

    // MARK: - Private properties

    private let errorParser: AbstractErrorParser

    // MARK: - Constructions

    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }

    // MARK: - Functions

    func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
        if let error = errorParser.parse(response: response, data: data, error: error) {
            throw error
        }

        do {
            let data = try DataResponseSerializer().serialize(
                request: request,
                response: response,
                data: data,
                error: error)

            let value = try JSONDecoder().decode(T.self, from: data)

            return value
        } catch {
            let customError = errorParser.parse(error)
            throw customError
        }
    }
}

// MARK: - Extensions

extension DataRequest {

    // MARK: - Functions

    @discardableResult func responseCodable<T: Decodable>(
        errorParser: AbstractErrorParser,
        queue: DispatchQueue = .main,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> Self {
        let responseSerializer = CustomDecodableSerializer<T>(errorParser: errorParser)

        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

