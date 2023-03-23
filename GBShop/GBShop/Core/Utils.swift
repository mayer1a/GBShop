//
//  Utils.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Alamofire

// MARK: - Typealias

typealias AFSignUpResult = AFDataResponse<SignUpResult>
typealias AFEditResult = AFDataResponse<EditProfileResult>
typealias AFSignInResult = AFDataResponse<SignInResult>
typealias UserDataKey = CoordinatorConstants.UserDataKey

// MARK: - App Constants

/// Application-wide text settings constants
struct Constants {

    // MARK: - Properties

    static let passwordMinLength = 8
    static let bioMaxSymbols = 500
    static var usernameLength = "\(usernameLengthRange.min),\(usernameLengthRange.max)"

    // MARK: - Private properties

    private static let usernameLengthRange: (min: Int, max: Int) = (6, 20)
}

// MARK: - Error Constants

/// Application-wide error constants
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
        "Номер карты имеет неправильный формат. Пожалуйста, отредактируйте его в формат ХХХХХХХХХХХХХХХХ"
    }()

    static let bioLengthMessage = {
        "Раздел \"О себе\" может содержать не более \(Constants.bioMaxSymbols) символов"
    }()
}


// MARK: - Layout Constants

/// Application-wide layout constants
struct LayoutConstants {
    static let sideIndents: CGFloat = 20.0
    static let textViewHeight: CGFloat = 50.0
    static let topIndent: CGFloat = 10.0
    static let centerYOffset: CGFloat = 30
    static let keyboardAdditionalIndent: CGFloat = 40.0
}

// MARK: - Animation Constants

/// Application-wide animation constants
struct AnimationConstants {
    static let animationDuration = 0.3
}

// MARK: - Coordinator Constants

struct CoordinatorConstants {

    // MARK: - UserDataKey

    enum UserDataKey {
        case user
    }

    // MARK: - Main App Flow

    enum AppFlow {
        case initial(InitialFlow)
        case tabBar(TabFlow)
    }

    enum InitialFlow {
        case initialScreen
        case signInScreen
        case signUpScreen
    }

    // MARK: - TabBar Flow

    enum TabFlow {
        case catalogFlow(CatalogFlow)
        case profileScreen
    }

    enum CatalogFlow {
        case catalogScreen
        case goodsScreen
    }
}
