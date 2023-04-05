//
//  Validator.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Foundation

/// Responsible for validating user input and may generate errors
final class Validator {

    // MARK: - Functions

    func validateEmail(_ email: String?) throws {
        guard let email, !email.isEmpty else {
            throw ValidationError.valueIsEmpty("E-mail")
        }

        if !isValidEmail(email) {
            throw ValidationError.emailWrongFormat
        }
    }

    /// Checks the password entered by the user against the rules and the password entered again
    /// - Parameters:
    ///   - password: Password or new password (for registration) required
    ///   - repeatPassword: The repeated password at registration can be nil if matching is not required
    func validatePassword(_ password: String?, repeatPassword: String? = nil) throws {
        guard let password, !password.isEmpty else {
            throw ValidationError.valueIsEmpty("Пароль")
        }

        if !isValidPassword(password) {
            throw ValidationError.passwordWrongFormat
        }

        if let repeatPassword, repeatPassword != password {
            throw ValidationError.passwordMismatch
        }
    }

    func validateUsername(_ username: String?) throws {
        guard let username, !username.isEmpty else {
            throw ValidationError.valueIsEmpty("Логин")
        }

        if !isValidUsername(username) {
            throw ValidationError.usernameWrongFormat
        }
    }

    func validateCard(_ cardNumber: String?) throws {
        guard let cardNumber, !cardNumber.isEmpty else {
            throw ValidationError.valueIsEmpty("Номер карты")
        }

        if !isValidCardNumber(cardNumber) {
            throw ValidationError.cardWrongFormat
        }
    }

    func validateBio(_ bio: String?) throws {
        guard let bio, !bio.isEmpty else {
            throw ValidationError.valueIsEmpty("Раздел \"О себе\"")
        }

        if !isValidBio(bio) {
            throw ValidationError.bioWrongLength
        }
    }

    func validateGender(_ gender: String?) throws {
        guard let gender, !gender.isEmpty else {
            throw ValidationError.valueIsEmpty("Пол (гендер)")
        }
    }

}

// MARK: - Extensions

extension Validator {

    // MARK: - Private functions

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{\(Constants.passwordMinLength),}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

        return passwordPredicate.evaluate(with: password)
    }

    private func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^(?=.*[a-z])[a-z\\d]{\(Constants.usernameLength)}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)

        return usernamePredicate.evaluate(with: username)
    }

    private func isValidCardNumber(_ cardNumber: String) -> Bool {
        let cardNumberRegex = "^[0-9]{16}$"
        let cardNumberPredicate = NSPredicate(format: "SELF MATCHES %@", cardNumberRegex)

        return cardNumberPredicate.evaluate(with: cardNumber)
    }

    private func isValidBio(_ bio: String) -> Bool {
        bio.count <= Constants.bioMaxSymbols
    }
}

extension Validator {

    /// Enumeration model of possible validation errors with localization of description
    enum ValidationError: Error, Equatable {
        case emailWrongFormat
        case passwordWrongFormat
        case passwordMismatch
        case usernameWrongFormat
        case cardWrongFormat
        case bioWrongLength
        case valueIsEmpty(String)
        case unknown

        var localizedDescription: String {
            switch self {
            case .emailWrongFormat:
                return ErrorConstants.emailFormatMessage
            case .passwordWrongFormat:
                return ErrorConstants.passwordFormatMessage
            case .usernameWrongFormat:
                return ErrorConstants.usernameFormatMessage
            case .cardWrongFormat:
                return ErrorConstants.cardFormatMessage
            case .bioWrongLength:
                return ErrorConstants.bioLengthMessage
            case .valueIsEmpty(let value):
                return value.appending(ErrorConstants.emptyValueMessage)
            case .passwordMismatch:
                return ErrorConstants.passwordMismatch
            default:
                return ErrorConstants.unknownErrorMessage
            }
        }

    }
}
