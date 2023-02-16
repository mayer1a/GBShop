//
//  CatalogGetting.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

class CatalogGetting: AbstractRequestFactory {

    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

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

extension CatalogGetting {

    // MARK: - RequestRouter

    struct CatalogGetting: RequestRouter {

        // MARK: - Properties

        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"

        let pageNumber: Int
        let categoryId: Int

        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId
            ]
        }
    }
}

extension CatalogGetting: CatalogGettingRequestFactory {

    // MARK: - Functions

    func getCatalog(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<[Product]>) -> Void
    ) {
        let requestModel = CatalogGetting(
            baseUrl: self.baseUrl,
            pageNumber: pageNumber,
            categoryId: categoryId)

        self.request(request: requestModel, completionHandler: completionHandler)
    }

}
