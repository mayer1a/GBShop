//
//  SignUpRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol SignUpRequestFactory {

    // MARK: - Functions

    func registration(
        username: String,
        password: String,
        email: String,
        gender: String,
        creditCardNumber: String,
        aboutMe: String,
        completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void)
}
