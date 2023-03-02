//
//  RequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

class RequestFactory {

    // MARK: - Properties

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default

        let manager = Session(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    // MARK: - Functions

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    func makeSignInRequestFatory() -> SignInRequestFactory {
        let errorParser = makeErrorParser()
        return SignIn(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParser = makeErrorParser()
        return SignUp(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeEditProfileRequestFactory() -> ProfileRequestFactory {
        let errorParser = makeErrorParser()
        return Profile(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeCatalogRequestFactory() -> CatalogRequestFactory {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeProductRequestFactory() -> GetProductRequestFactory {
        let errorParser = makeErrorParser()
        return GetProduct(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeReviewsRequestFactory() -> ReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeBasketRequestFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

}
