//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 14.02.2023.
//

import Alamofire

protocol LogoutRequestFactory {

    // MARK: - Functions

    func logout(
        userId: Int,
        completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
