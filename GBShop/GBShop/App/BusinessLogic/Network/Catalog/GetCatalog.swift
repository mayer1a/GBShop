//
//  GetCatalog.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

// MARK: - AbstractRequestFactory

class GetCatalog: AbstractRequestFactory {

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

extension GetCatalog {

    // MARK: - RequestRouter

    struct GetCatalog: RequestRouter {

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

// MARK: - GetCatalogRequestFactory

extension GetCatalog: GetCatalogRequestFactory {

    // MARK: - Functions

    func getCatalog(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void
    ) {
        let requestModel = GetCatalog(
            baseUrl: self.baseUrl,
            pageNumber: pageNumber,
            categoryId: categoryId)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
