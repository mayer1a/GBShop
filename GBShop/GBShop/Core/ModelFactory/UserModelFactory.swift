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

    func construct(from model: SignUpRawModel) -> SignUpUser? {
        guard
            let password = model.password,
            let name = model.name,
            let lastname = model.lastname,
            let username = model.username,
            let email = model.email,
            let cardNumber = model.creditCard,
            let genderString = model.gender,
            let gender = Gender(rawValue: genderString),
            let bio = model.bio
        else {
            return nil
        }

        return SignUpUser(
            name: name,
            lastname: lastname,
            username: username,
            password: password,
            email: email,
            creditCard: cardNumber,
            gender: gender,
            bio: bio)
    }
}
