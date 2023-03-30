//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Alamofire

/// Server request factory contract for basket actions
protocol BasketRequestFactory {

    // MARK: - Functions

    func addProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFDataResponse<AddProductResult>) -> Void)

    func editProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFDataResponse<EditProductResult>) -> Void)

    func removeProduct(
        userId: Int,
        productId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveProductResult>) -> Void)

    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)

    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
