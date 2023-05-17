//
//  ProfileRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

/// Server request factory contract to modify user profile data
protocol ProfileRequestFactory {

    // MARK: - Functions

    /// Sends a request to change user data to the server with updated user data
    /// - Parameters:
    ///   - profile: Updated user profile to send a request to the server.
    ///   - completionHandler: Received response from the server.
    func editProfile(
        profile: EditProfile,
        completionHandler: @escaping (AFDataResponse<EditProfileResult>) -> Void)
}
