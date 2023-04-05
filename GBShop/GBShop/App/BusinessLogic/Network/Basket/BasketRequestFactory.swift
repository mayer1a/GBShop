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

    /// You can add a product like ``BasketElement`` to basket.
    /// - Parameters:
    ///   - userId: User ID of which the item is to be added to the cart.
    ///   - basketElement: Product as ``BasketElement`` that will be sent to the server to be added to the basket.
    ///   - completionHandler: Received response from the server.
    func addProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFBasketResult) -> Void)

    /// You can edit the quantity of the item in the basket.
    /// - Parameters:
    ///   - userId: User ID in whose cart you want to edit the quantity of product.
    ///   - basketElement: Product as ``BasketElement`` that will be sent to the server to edit the quantity of product.
    ///   - completionHandler: Received response from the server.
    func editProduct(
        userId: Int,
        basketElement: BasketElement,
        completionHandler: @escaping (AFBasketResult) -> Void)

    /// You can remove a product like ``BasketElement`` from basket.
    /// - Parameters:
    ///   - userId: User ID of which the item is to be removed from the cart.
    ///   - productId: Product ID that will be sent to the server to be removed from the basket.
    ///   - completionHandler: Received response from the server.
    func removeProduct(
        userId: Int,
        productId: Int,
        completionHandler: @escaping (AFBasketResult) -> Void)

    /// Get a list of items in the user's shopping cart
    /// - Parameters:
    ///   - userId: User ID for which you want to get the basket.
    ///   - completionHandler: Received response from the server.
    func getBasket(userId: Int, completionHandler: @escaping (AFBasketResult) -> Void)

    /// Send a request to pay the user's cart to the server
    /// - Parameters:
    ///   - userId: User ID whose cart will be paid for.
    ///   - completionHandler: Received response from the server.
    func payBasket(userId: Int, completionHandler: @escaping (AFPayBasketResult) -> Void)
}
