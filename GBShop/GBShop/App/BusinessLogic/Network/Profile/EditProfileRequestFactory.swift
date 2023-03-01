//
//  EditProfileRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol EditProfileRequestFactory {

    // MARK: - Functions

    func editProfile(
        profile: EditUserProfile,
        completionHandler: @escaping (AFDataResponse<EditProfileResult>) -> Void)
}
