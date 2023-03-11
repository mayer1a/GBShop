//
//  RealmLayer.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Foundation
import RealmSwift

protocol UserCredentialRealmStorage {
    @discardableResult func create<T: Object>(_ object: T) -> Bool
    func read<T: Object>(of type: T.Type) -> Results<T>
    func update<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func delete<T: Object>(_ objects: Results<T>)
}

final class RealmLayer: UserCredentialRealmStorage {

    // MARK: - Properties

    var realm: Realm

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

    func read<T: Object>(of type: T.Type) -> Results<T> {
        realm.objects(type)
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

    func delete<T: Object>(_ objects: Results<T>) {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
