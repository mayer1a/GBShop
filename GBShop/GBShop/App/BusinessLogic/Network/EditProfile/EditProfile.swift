//
//  EditProfile.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

class EditProfile: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

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
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"

        let userId: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let creditCardNumber: String
        let aboutMe: String

        var parameters: Parameters? {
            return [
                "id_user": userId,
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

extension EditProfile: EditProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        userId: Int,
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCardNumber: String,
        aboutMe: String,
        completionHandler: @escaping (Alamofire.AFDataResponse<ProfileEditResult>) -> Void
    ) {
        let requestModel = EditProfile(
            baseUrl: self.baseUrl,
            userId: userId,
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
