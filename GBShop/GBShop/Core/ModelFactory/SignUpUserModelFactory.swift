//
//  SignUpModelFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 12.03.2023.
//

import Foundation

struct SignUpUserModelFactory {

    // MARK: - Functions

    func construct(from objects: RawSignUpModel) -> SignUpUser? {
        guard
            let name = objects[.name],
            let lastname = objects[.lastname],
            let username = objects[.username],
            let password = objects[.password],
            let email = objects[.email],
            let cardNumber = objects[.cardNumber],
            let genderString = objects[.gender],
            let gender = Gender(rawValue: genderString),
            let bio = objects[.bio]
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
