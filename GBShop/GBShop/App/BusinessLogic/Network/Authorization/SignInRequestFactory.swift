//
//  SignInRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

protocol SignInRequestFactory {

    // MARK: - Functions

    func login(
        email: String,
        password: String,
        completionHandler: @escaping (AFDataResponse<SignInResult>) -> Void)
}
