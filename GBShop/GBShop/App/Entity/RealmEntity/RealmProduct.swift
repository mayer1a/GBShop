//
//  RealmProduct.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import RealmSwift

/// Product data model for Realm database.
final class RealmProduct: Object {

    // MARK: - Properties

    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var name: String
    @Persisted
    var category: String
    @Persisted
    var price: Int
    @Persisted
    var mainImage: String
}
