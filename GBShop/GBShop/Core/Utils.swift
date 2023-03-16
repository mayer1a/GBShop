//
//  Utils.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Alamofire

// MARK: - Typealias

typealias AFSignUpResult = AFDataResponse<SignUpResult>

// MARK: - App Constants

struct Constants {

    // MARK: - Properties

    static let passwordMinLength = 8
    static let bioMaxSymbols = 500
    static var usernameLength = "\(usernameLengthRange.min),\(usernameLengthRange.max)"

    // MARK: - Private properties

    private static let usernameLengthRange: (min: Int, max: Int) = (6, 20)
}

// MARK: - Error Constants

struct ErrorConstants {

    // MARK: - Properties

    static let unknownErrorMessage = "Произошла неизвестная ошибка."
    static let emptyValueMessage = " пустой. Пожалуйста, заполните его."
    static let emailFormatMessage = "Электронная почта имеет неправильный формат. Пожалуйста, отредактируйте его."
    static let passwordMismatch = "Введённые пароли не совпадают. Пожалуйста, исправьте это."
    static let passwordFormatMessage = {
        let length = Constants.passwordMinLength
        return "Пароль должен быть не менее \(length) символов и содержать заглавную букву, строчную букву и цифру."
    }()

    static let usernameFormatMessage = {
        let lengthRange = Constants.usernameLength.replacingOccurrences(of: ",", with: " до ")
        return "Логин должен быть от \(lengthRange) символов, состоять из строчных букв и может иметь цифры."
    }()

    static let cardFormatMessage = {
        "Номер карты имеет неправильный формат. Пожалуйста, отредактируйте его в формат ХХХХ-ХХХХ-ХХХХ-ХХХХ"
    }()

    static let bioLengthMessage = {
        "Раздел \"О себе\" может содержать не более \(Constants.bioMaxSymbols) символов"
    }()
}
