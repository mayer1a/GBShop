//
//  CatalogStorageService.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import RealmSwift

/// Service for working with local storage for product data using ``RealmLayer``
final class ProductsStorageService {

    // MARK: - Private properties

    private var realm: UserCredentialRealmStorage
    private static let productCollectionSize = 20

    // MARK: - Constructions

    /// Initializer with default initialization values. You can initialize with already existing layers and reuse them.
    init(realm: UserCredentialRealmStorage = RealmLayer()) {
        self.realm = realm
    }

    // MARK: - Public properties

    /// Get product from local storage (a.k.a **Realm**) by product id.
    ///
    /// > Warning:
    /// > If the products record does not exist, an empty product model will be returned.
    func read(by id: Int) -> Product {
        let realmProduct = realm.read(of: RealmProduct.self).filter("ANY id == \(id)").first ?? .init()
        return realmToModel(realmProduct)
    }

    func read(_ count: Int = productCollectionSize) -> [Product] {
        let realmProducts = realm.read(of: RealmProduct.self, count)
        return realmToModel(realmProducts)
    }

    /// Creates a products records in local storage (a.k.a **Realm**).
    func createProducts(from product: [Product]) {
        product.forEach { createProduct($0) }
    }

    /// Updates a products entry in local storage (a.k.a **Realm**).
    func updateProducts(from products: [Product]) {
        products.forEach { updateProduct($0) }
    }

    /// Deletes a products entry in local storage (a.k.a **Realm**).
    func deleteProducts(from products: [Product]) {
        products.forEach { deleteProduct($0) }
    }

}

// MARK: - Extensions

private extension ProductsStorageService {

    // MARK: - Private functions

    private func updateProduct(_ product: Product) {
        let realmProduct = modelToRealm(product)
        realm.update(realmProduct)
    }

    private func createProduct(_ product: Product) {
        let realmProduct = modelToRealm(product)
        realm.create(realmProduct)
    }

    private func deleteProduct(_ product: Product) {
        let realmProduct = modelToRealm(product)
        realm.delete(realmProduct)
    }

    /// Turns a ``RealmProduct`` collection data model into a ``Product`` collection data model.
    private func realmToModel(_ objects: [RealmProduct]) -> [Product] {
        objects.map { realmToModel($0) }
    }

    /// Turns a ``Product`` collection data model into a ``RealmProduct`` collection data model.
    private func modelToRealm(_ products: [Product]) -> [RealmProduct] {
        products.map { modelToRealm($0) }
    }

    /// Turns a ``RealmProduct`` data model into a ``Product`` data model.
    private func realmToModel(_ object: RealmProduct) -> Product {
        let product = Product(
            id: object.id,
            name: object.name,
            price: object.price)

        return product
    }

    /// Turns a ``Product`` data model into a ``RealmProduct`` data model.
    private func modelToRealm(_ product: Product) -> RealmProduct {
        let realmProduct = RealmProduct()
        realmProduct.id = product.id
        realmProduct.name = product.name
        realmProduct.price = product.price

        return realmProduct
    }
}
