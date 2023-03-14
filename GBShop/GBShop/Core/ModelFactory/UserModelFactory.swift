//
//  UserModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 12.03.2023.
//

import Foundation

struct UserModelFactory {

    // MARK: - Functions

    func construct(from signUpModel: SignUpUser, with id: Int) -> User {
        User(
            id: id,
            username: signUpModel.username,
            name: signUpModel.name,
            email: signUpModel.email,
            creditCard: signUpModel.creditCard,
            lastname: signUpModel.lastname,
            gender: signUpModel.gender,
            bio: signUpModel.bio)
    }
}
