//
//  EditProfileRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol EditProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        userId: Int,
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCardNumber: String,
        aboutMe: String,
        completionHandler: @escaping (AFDataResponse<ProfileEditResult>) -> Void)
}
