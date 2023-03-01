//
//  ProfileRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol ProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        profile: EditProfile,
        completionHandler: @escaping (AFDataResponse<EditProfileResult>) -> Void)
}
