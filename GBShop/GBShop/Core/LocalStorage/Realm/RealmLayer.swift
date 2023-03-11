//
//  RealmLayer.swift
//  GBShop
//
//  Created by Artem Mayer on 11.03.2023.
//

import Foundation
import RealmSwift

final class RealmLayer: UserCredentialRealmStorage {

    // MARK: - Properties

    var realm: Realm

    // MARK: - Constructions

    init() {
        self.realm = try! Realm()
    }

    // MARK: - Functions

    func create<T: Object>(_ object: T) {
        if let existsObject = realm.object(ofType: T.self, forPrimaryKey: "id") {
            delete(existsObject)
        }

        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func read<T: Object>(of type: T.Type) -> T {
        realm.object(ofType: type, forPrimaryKey: "id") ?? T()
    }

    func update<T: Object>(_ object: T) {
        do {
            try realm.write {

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
}
