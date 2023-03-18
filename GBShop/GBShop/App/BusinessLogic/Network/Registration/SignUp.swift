//
//  SignUp.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

/// `SignUp` implements sending requests related to user registration to the server.
class SignUp: AbstractRequestFactory {

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

extension SignUp {

    // MARK: - RequestRouter

    struct SignUpRequest: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signup"

        let profile: SignUpUser

        var parameters: Parameters? {
            return [
                "name": profile.name,
                "lastname": profile.lastname,
                "username": profile.username,
                "password": profile.password,
                "email": profile.email,
                "gender": profile.gender,
                "credit_card": profile.creditCard,
                "bio": profile.bio
            ]
        }
    }
}

// MARK: - SignUpRequestFactory

extension SignUp: SignUpRequestFactory {

    // MARK: - Functions

    func registration(
        profile: SignUpUser,
        completionHandler: @escaping (Alamofire.AFDataResponse<SignUpResult>) -> Void
    ) {
        let requestModel = SignUpRequest(
            baseUrl: self.baseUrl,
            profile: profile)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
