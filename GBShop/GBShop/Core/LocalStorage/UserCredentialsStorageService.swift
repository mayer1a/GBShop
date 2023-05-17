//
//  UserCredentialsStorageService.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation

protocol UserStorageServiceInterface: AnyObject {

    /// Checks if the user is logged in or not
    var isUserAuthenticated: Bool { get }

    /// Get user from local storage (a.k.a **Realm**).
    /// > Warning:
    /// > It can be obtained only after checking the existence of a user record by the corresponding field ``isUserAuthenticated``.
    /// >
    /// > If the user record does not exist, an empty user model will be returned.
    var user: User { get }

    /// Creates a user record in local storage (a.k.a **Realm**).
    /// - Note: If the record was created successfully, the ``isUserAuthenticated`` property will also change to `true`
    func createUser(from user: User)

    /// Updates a user entry in local storage (a.k.a **Realm**).
    func updateUser(from user: User)

    /// Deletes a user entry in local storage (a.k.a **Realm**).
    func deleteUser()

    /// Deletes a user entry in local storage (a.k.a **Realm**) and UD value set false for key "isUserAuthenticated".
    func userDidExit(_ user: User)
}

/// Service for working with local storage for user credentials data using ``RealmLayer`` and ``UserDefaultsLayer``
final class UserCredentialsStorageService: UserStorageServiceInterface {

    // MARK: - Private properties

    private var storage: UserCredentialStorage
    private var realm: UserCredentialRealmStorage

    // MARK: - Constructions

    /// Initializer with default initialization values. You can initialize with already existing layers and reuse them.
    init(storage: UserCredentialStorage = UserDefaultsLayer(), realm: UserCredentialRealmStorage = RealmLayer()) {
        self.storage = storage
        self.realm = realm
    }

    // MARK: - Properties

    private(set) var isUserAuthenticated: Bool {
        get {
            storage.isUserAuthenticated
        }
        set {
            storage.isUserAuthenticated = newValue
        }
    }

    var user: User {
        get {
            let realmUser = realm.read(of: RealmUser.self).first ?? .init()
            return realmToModel(realmUser)
        }
    }

    // MARK: - Functions

    func createUser(from user: User) {
        let realmUser = modelToRealm(user)
        let isCreateSuccessfull = realm.create(realmUser)
        isUserAuthenticated = isCreateSuccessfull
    }

    func updateUser(from user: User) {
        let realmUser = modelToRealm(user)
        realm.update(realmUser)
    }

    func deleteUser() {
        guard let realmUser = realm.read(of: RealmUser.self).first else { return }
        realm.delete(realmUser)
    }

    func userDidExit(_ user: User) {
        deleteUser()
        isUserAuthenticated = false
    }
}

// MARK: - Extensions

private extension UserCredentialsStorageService {

    // MARK: - Private functions

    private func realmToModel(_ object: RealmUser) -> User {
        let gender = Gender(rawValue: object.gender.rawValue) ?? .indeterminate
        let user = User(
            id: object.id,
            username: object.username,
            name: object.name,
            email: object.email,
            creditCard: object.creditCard,
            lastname: object.lastname,
            gender: gender,
            bio: object.bio)

        return user
    }

    private func modelToRealm(_ user: User) -> RealmUser {
        let realmUser = RealmUser()
        realmUser.id = user.id
        realmUser.username = user.username
        realmUser.name = user.name
        realmUser.email = user.email
        realmUser.creditCard = user.creditCard
        realmUser.lastname = user.lastname
        realmUser.gender = .init(rawValue: user.gender.rawValue) ?? .indeterminate
        realmUser.bio = user.bio

        return realmUser
    }
}
