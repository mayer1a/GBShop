//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

protocol AuthRequestFactory {

    // MARK: - Functions

    func login(
        userName: String,
        password: String,
        completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
