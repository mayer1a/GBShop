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

    func editProfile(
        profile: EditProfile,
        completionHandler: @escaping (AFDataResponse<EditProfileResult>) -> Void)
}
