//
//  EditProfile.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class EditProfile: AbstractRequestFactory {

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

extension EditProfile {

    // MARK: - RequestRouter

    struct EditProfile: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "edit-profile"

        let profile: EditUserProfile

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

extension EditProfile: EditProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        profile: EditUserProfile,
        completionHandler: @escaping (Alamofire.AFDataResponse<EditProfileResult>) -> Void
    ) {
        let requestModel = EditProfile(
            baseUrl: self.baseUrl,
            profile: profile)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

