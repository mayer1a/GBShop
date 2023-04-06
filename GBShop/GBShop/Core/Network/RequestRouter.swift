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

/// The main request router contract inherits from **URLRequestConvertible**
///
/// Contains basic request parameters:
/// - ``baseUrl`` - base url address of server request
/// - ``fullUrl-1pwda`` - full address containing ``baseUrl`` and additional address ``path`` with request path
/// - ``path`` - additional address with request path
/// - ``method`` - request method such as **GET**, **POST**, etc.
/// - ``parameters`` - request parameters
/// - ``encoding-9djhk`` - enumeration of encoding type ``RequestRouterEncoding/url`` or ``RequestRouterEncoding/json``
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
        baseUrl.appendingPathComponent(path)
    }

    var encoding: RequestRouterEncoding {
        .url
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
