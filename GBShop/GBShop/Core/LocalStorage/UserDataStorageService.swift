//
//  UserDataStorageService.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation

protocol UserCredentialStorage {
    var isUserAuthenticated: Bool { get set }
}

final class UserCredentialsStorageService {

    // MARK: - Private properties

    private var storage: UserCredentialStorage

    // MARK: - Constructions

    init(storage: UserCredentialStorage = UserDefaultsLayer()) {
        self.storage = storage
    }

    // MARK: - Public properties

    public var isUserAuthenticated: Bool {
        get {
            return storage.isUserAuthenticated
        } set {
            storage.isUserAuthenticated = newValue
        }
    }

}
