//
//  SignInRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Alamofire

/// Server request factory contract for user authorization actions
protocol SignInRequestFactory {

    // MARK: - Functions

    /// Send a request to the server to sign in the user
    /// - Parameters:
    ///   - email: User actual email for which you want to sign in.
    ///   - password: User actual password for which you want to sign in.
    ///   - completionHandler: Received response from the server.
    func login(
        email: String,
        password: String,
        completionHandler: @escaping (AFDataResponse<SignInResult>) -> Void)
}
