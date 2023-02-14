//
//  RequestRouter.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

enum RequestRouterEncoding {
    case url, json
}

// MARK: - URLRequestConvertible

protocol RequestRouter: URLRequestConvertible {

    // MARK: - Properties

    var baseUrl: URL { get }
    var fullUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: RequestRouterEncoding { get }
}

// MARK: - Extensions

extension RequestRouter {

    // MARK: - Properties

    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }

    var encoding: RequestRouterEncoding {
        return .url
    }

    // MARK: - Functions

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue

        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
