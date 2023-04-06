//
//  RealmLayer.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Foundation
import RealmSwift

/// Contract obliging to implement standard **CRUD** methods for `Realm` database management
protocol UserCredentialRealmStorage {

    /// Creates a user record in local storage for object of type `T` where T: `Objects`.
    /// - Note: If the record was created successfully returns `true`
    @discardableResult func create<T: Object>(_ object: T) -> Bool

    /// Get product from local storage.
    /// - Returns:
    ///    A result of generic ``Results<T>`` type where T : ``RealmSwiftObject``
    func read<T: Object>(of type: T.Type) -> Results<T>

    /// Get products from local storage by number of elements.
    /// - Returns:
    ///    An array of generic ``T`` type where T : ``Object``
    func read<T: Object>(of type: T.Type, _ elementsCount: Int) -> [T]

    /// Updates a product entry in local storage for object of type `T` where T: `Objects`.
    func update<T: Object>(_ object: T)

    /// Deletes a product entry in local storage for object of type `T` where T: `Objects`.
    func delete<T: Object>(_ object: T)

    /// Deletes products entry in local storage for object of type `T` where T: `Sequence` and T.Element: `Object`.
    func delete<T: Sequence>(_ objects: T) where T.Element: Object
}

/// `RealmLayer` is a layer with generic methods that is responsible for working with the  **Realm**, regardless of the data model being sent/requested
final class RealmLayer: UserCredentialRealmStorage {

    // MARK: - Private properties

    private var realm: Realm

    // MARK: - Constructions

    init() {
        self.realm = try! Realm()
    }

    // MARK: - Functions

    @discardableResult func create<T: Object>(_ object: T) -> Bool {
        let existsObjects = realm.objects(T.self)

        if !existsObjects.isEmpty {
            delete(existsObjects)
        }

        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
            return false
        }

        return true
    }

    @discardableResult
    func create<T: Sequence>(_ objects: T) -> Bool where T.Element: Object {
        let existsObjects = realm.objects(T.Element.self)

        if !existsObjects.isEmpty {
            delete(existsObjects)
        }

        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print(error.localizedDescription)
            return false
        }

        return true
    }

    func read<T: Object>(of type: T.Type) -> Results<T> {
        realm.objects(type)
    }

    func read<T: Object>(of type: T.Type, _ elementsCount: Int) -> [T] {
        Array(realm.objects(type).toArray()[..<elementsCount])
    }

    func update<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object,update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete<T: Sequence>(_ objects: T) where T.Element: Object {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Extesnions

extension Results {

    // MARK: - Functions

    func toArray() -> [Self.Element] {
        self.map { $0 }
    }
}
