//
//  SignUp.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

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

    struct SignUp: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signup"

        let userId: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let creditCardNumber: String
        let aboutMe: String

        var parameters: Parameters? {
            return [
                "user_id": userId,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCardNumber,
                "bio": aboutMe
            ]
        }
    }
}

// MARK: - SignUpRequestFactory

extension SignUp: SignUpRequestFactory {

    // MARK: - Functions

    func registration(
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCardNumber: String,
        aboutMe: String,
        completionHandler: @escaping (Alamofire.AFDataResponse<SignUpResult>) -> Void
    ) {
        let requestModel = SignUp(
            baseUrl: self.baseUrl,
            userId: UniqueID.getUniqueId(),
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
