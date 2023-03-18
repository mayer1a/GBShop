//
//  RealmUser.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import RealmSwift

/// User data model for Realm database.
final class RealmUser: Object {

    /// Gender inner model for Realm database.
    enum Gender: String, PersistableEnum {
        case man = "Мужской"
        case woman = "Женский"
        case indeterminate = "Другой"
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
}
