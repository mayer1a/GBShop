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

        let editProfileUser: EditProfileUser

        var parameters: Parameters? {
            return [
                "user_id": editProfileUser.id,
                "username": editProfileUser.username,
                "password": editProfileUser.password,
                "email": editProfileUser.email,
                "gender": editProfileUser.gender,
                "credit_card": editProfileUser.creditCard,
                "bio": editProfileUser.bio
            ]
        }
    }
}

// MARK: - EditProfileRequestFactory

extension EditProfile: EditProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        editProfileUser: EditProfileUser,
        completionHandler: @escaping (Alamofire.AFDataResponse<ProfileEditResult>) -> Void
    ) {
        let requestModel = EditProfile(
            baseUrl: self.baseUrl,
            editProfileUser: editProfileUser)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

