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
    @discardableResult func create<T: Object>(_ object: T) -> Bool
    func read<T: Object>(of type: T.Type) -> Results<T>
    func read<T: Object>(of type: T.Type, _ elementsCount: Int) -> [T]
    func update<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func delete<T: Object>(_ objects: Results<T>)
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

    @discardableResult
    func create<T: Object>(_ object: T) -> Bool {
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

    /// Removes an object from a **Realm**
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Removes a collection/sequence of objects from a **Realm**
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
