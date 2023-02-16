//
//  CatalogGettingRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 16.02.2023.
//

import Alamofire

protocol CatalogGettingRequestFactory {

    // MARK: - Functions

    func registration(
        pageNumber: Int,
        categoryId: Int,
        completionHandler: @escaping (AFDataResponse<CatalogGettingResult>) -> Void)
}
