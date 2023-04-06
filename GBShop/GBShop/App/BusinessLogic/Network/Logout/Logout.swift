//
//  Logout.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

/// `Logout` implements sending requests related to the user's exit from the profile to the server.
final class Logout: AbstractRequestFactory {

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

extension Logout {

    // MARK: - RequestRouter

    struct Logout: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"

        let userId: Int

        var parameters: Parameters? {
            ["user_id": userId]
        }
    }
}

// MARK: - LogoutRequestFactory

extension Logout: LogoutRequestFactory {

    // MARK: - Functions

    func logout(userId: Int, completionHandler: @escaping (Alamofire.AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: self.baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
