//
//  Catalog.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

/// `Catalog` implements sending requests related to obtaining a catalog of goods to the server.
final class Catalog: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

    // MARK: - Constructions

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

// MARK: - Extensions

extension Catalog {

    // MARK: - RequestRouter

    struct CatalogRequest: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalog"

        let pageNumber: Int
        let categoryId: Int

        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "category_id": categoryId
            ]
        }
    }
}

// MARK: - CatalogRequestFactory

extension Catalog: CatalogRequestFactory {

    // MARK: - Functions

    func getCatalog(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void
    ) {
        let requestModel = CatalogRequest(
            baseUrl: self.baseUrl,
            pageNumber: pageNumber,
            categoryId: categoryId)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
