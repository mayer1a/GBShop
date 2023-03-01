//
//  Profile.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class Profile: AbstractRequestFactory {

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

extension Profile {

    // MARK: - RequestRouter

    struct ProfileRequest: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "edit-profile"

        let profile: EditProfile

        var parameters: Parameters? {
            return [
                "user_id": profile.id,
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

// MARK: - EditProfileRequestFactory

extension Profile: ProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        profile: EditProfile,
        completionHandler: @escaping (Alamofire.AFDataResponse<EditProfileResult>) -> Void
    ) {
        let requestModel = ProfileRequest(
            baseUrl: self.baseUrl,
            profile: profile)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

