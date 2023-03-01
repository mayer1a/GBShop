//
//  GetCatalogRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

protocol CatalogRequestFactory {

    // MARK: - Functions

    func getCatalog(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
}
