//
//  RegistrationRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol RegistrationRequestFactory {

    // MARK: - Functions

    func registration(
        userId: Int,
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCardNumber: String,
        aboutMe: String,
        completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
