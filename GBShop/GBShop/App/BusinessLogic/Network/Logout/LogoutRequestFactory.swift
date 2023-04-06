//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

/// Request factory contract to notify the server when a user has logged out of a profile
protocol LogoutRequestFactory {

    // MARK: - Functions

    /// Send a request to the server to log out the user
    /// - Parameters:
    ///   - userId: User ID for which you want to log out.
    ///   - completionHandler: Received response from the server.
    func logout(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
