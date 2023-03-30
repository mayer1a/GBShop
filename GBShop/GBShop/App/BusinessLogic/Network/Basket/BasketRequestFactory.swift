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
        completionHandler: @escaping (AFBasketResult) -> Void)

    func editProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFBasketResult) -> Void)

    func removeProduct(
        userId: Int,
        productId: Int,
        completionHandler: @escaping (AFBasketResult) -> Void)

    func getBasket(userId: Int, completionHandler: @escaping (AFBasketResult) -> Void)

    func payBasket(userId: Int, completionHandler: @escaping (AFPayBasketResult) -> Void)
}
