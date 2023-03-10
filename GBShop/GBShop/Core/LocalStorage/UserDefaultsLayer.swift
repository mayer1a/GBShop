//
//  UserDefaultsLayer.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation

final class UserDefaultsLayer: UserCredentialStorage {

    // MARK: - Private properties

    private let defaults: UserDefaults

    // MARK: - Constructions

    init(suiteName: String? = nil) {
        defaults = UserDefaults(suiteName: suiteName)!
    }

    // MARK: - Public properties

    public var isUserAuthenticated: Bool {
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
