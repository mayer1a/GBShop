//
//  UserCredentialsStorageService.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation

final class UserCredentialsStorageService {

    // MARK: - Private properties

    private var storage: UserCredentialStorage
    private var realm: UserCredentialRealmStorage

    // MARK: - Constructions

    init(storage: UserCredentialStorage = UserDefaultsLayer(), realm: UserCredentialRealmStorage = RealmLayer()) {
        self.storage = storage
        self.realm = realm
    }

    // MARK: - Public properties

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

    func createUser(from user: User) {
        let realmUser = modelToRealm(user)
        let isCreateSuccessfull = realm.create(realmUser)
        isUserAuthenticated = isCreateSuccessfull
    }

    func updateUser(from user: User) {
        let realmUser = modelToRealm(user)
        realm.update(realmUser)
    }

    func deleteUser(from user: User) {
        let realmUser = modelToRealm(user)
        realm.delete(realmUser)
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
