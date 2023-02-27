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

    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeRegistrationRequestFactory() -> RegistrationRequestFactory {
        let errorParser = makeErrorParser()
        return Registration(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeEditProfileRequestFactory() -> EditProfileRequestFactory {
        let errorParser = makeErrorParser()
        return EditProfile(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeCatalogGettingRequestFactory() -> CatalogGettingRequestFactory {
        let errorParser = makeErrorParser()
        return CatalogGetting(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeProductGettingRequestFactory() -> ProductGettingRequestFactory {
        let errorParser = makeErrorParser()
        return ProductGetting(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeReviewsRequestFactory() -> ReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeApproveReviewRequestFactory() -> ApproveReviewRequestFactory {
        let errorParser = makeErrorParser()
        return ApproveReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

}
