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
        profile: SignUpUser,
        completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void)
}
