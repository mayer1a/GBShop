//
//  SignIn.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class SignIn: AbstractRequestFactory {

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

extension SignIn {

    // MARK: - RequestRouter

    struct SignIn: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signin"

        let email: String
        let password: String

        var parameters: Parameters? {
            return [
                "email": email,
                "password": password
            ]
        }
    }
}

// MARK: - SignInRequestFactory

extension SignIn: SignInRequestFactory {

    // MARK: - Functions

    func login(
        email: String,
        password: String,
        completionHandler: @escaping (AFDataResponse<SignInResult>) -> Void
    ) {
        let requestModel = SignIn(baseUrl: baseUrl, email: email, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
