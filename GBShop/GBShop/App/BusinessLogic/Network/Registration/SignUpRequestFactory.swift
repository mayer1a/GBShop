//
//  SignUpRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

/// Server request factory contract for user registration
protocol SignUpRequestFactory {

    // MARK: - Functions

    /// Sends a registration request to the server with filled in user data
    /// - Parameters:
    ///   - profile: User profile to send a registration request to the server.
    ///   - completionHandler: Received response from the server.
    func registration(
        profile: SignUpUser,
        completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void)
}
