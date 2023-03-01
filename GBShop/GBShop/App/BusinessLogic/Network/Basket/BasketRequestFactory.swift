//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

protocol BasketRequestFactory {

    // MARK: - Functions

    func addProduct(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddProductResult>) -> Void)

    func removeProduct(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveProductResult>) -> Void)

    func payBasket(completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
