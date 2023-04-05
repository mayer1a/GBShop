//
//  SignUpRawModel.swift
//  GBShop
//
//  Created by Artem Mayer on 15.03.2023.
//

import UIKit

/// The data model of the `SignUpModule` for sending data between the view and the presenter.
final class SignUpRawModel {

    // MARK: - Constructions

    init() {}

    required init(
        name: String?,
        lastname: String?,
        username: String?,
        password: String?,
        repeatPassword: String?,
        email: String?,
        creditCard: String?,
        gender: String?,
        bio: String?
    ) {
        self.name = name
        self.lastname = lastname
        self.username = username
        self.password = password
        self.repeatPassword = repeatPassword
        self.email = email
        self.creditCard = creditCard
        self.gender = gender
        self.bio = bio
    }

    // MARK: - Properties

    var name: String?
    var lastname: String?
    var username: String?
    var password: String?
    var repeatPassword: String?
    var email: String?
    var creditCard: String?
    var gender: String?
    var bio: String?
}
