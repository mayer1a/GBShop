//
//  UserDefaultsLayer.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation

/// Contract for checking user authorization
protocol UserCredentialStorage {
    var isUserAuthenticated: Bool { get set }
}

/// `UserDefaultsLayer` is a layer with methods that is responsible for working with the  **UserDefaults**
final class UserDefaultsLayer: UserCredentialStorage {

    // MARK: - Private properties

    private let defaults: UserDefaults

    // MARK: - Constructions

    init(suiteName: String? = nil) {
        defaults = UserDefaults(suiteName: suiteName)!
    }

    // MARK: - Public properties

    /// Responsible for the user's authentication state.
    /// - Note: Returns  `true` if the user is logged in. When setting a new value, writes it to the **UserDefaults**
    var isUserAuthenticated: Bool {
        get {
            defaults.bool(forKey: GeneralKeys.isUserAuthenticated)
        } set {
            defaults.set(newValue, forKey: GeneralKeys.isUserAuthenticated)
        }
    }
}

// MARK: - Extension

extension UserDefaultsLayer {

    // MARK: - Private struct
    
    private struct GeneralKeys {
        static let isUserAuthenticated = "isUserAuthenticated"
    }
}
