//
//  UserCredentialsStorageService.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import Foundation
import RealmSwift

protocol UserCredentialRealmStorage {
    func create<T: Object>(_ object: T)
    func read<T: Object>(of type: T.Type) -> T
    func update<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
}

protocol UserCredentialStorage {
    var isUserAuthenticated: Bool { get set }
}

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

    public var isUserAuthenticated: Bool {
        get {
            storage.isUserAuthenticated
        } set {
            storage.isUserAuthenticated = newValue
        }
    }

    public var user: User {
        get {
            let realmUser = realm.read(of: RealmUser.self)
            return realmToModel(realmUser)
        }
    }

    public func createUser(from user: User) {
        let realmUser = modelToRealm(user)
        realm.create(realmUser)
    }

    public func updateUser(from user: User) {
        let realmUser = modelToRealm(user)
        realm.update(realmUser)
    }

    public func deleteUser(from user: User) {
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

class RealmUser: Object {

    enum Gender: String, PersistableEnum {
        case man
        case woman
        case indeterminate
    }

    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var username: String
    @Persisted
    var name: String
    @Persisted
    var email: String
    @Persisted
    var creditCard: String
    @Persisted
    var lastname: String
    @Persisted
    var gender: Gender
    @Persisted
    var bio: String

    override static func primaryKey() -> String? {
        return "id"
    }
}
