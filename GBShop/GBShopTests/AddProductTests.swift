//
//  AddProductTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 01.03.2023.
//

import XCTest
@testable import GBShop

final class AddProductTests: XCTestCase {

    // MARK: - Properties

    var requestFactory: RequestFactory!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    // MARK: - Functions

    func test1AddProductCorrectInput() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let product = Product(
            id: 23019,
            name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            price: 2378,
            mainImage: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp")
        let quantity = BasketElement(product: product, quantity: 1)
        var addProductResult: GetBasketResult? = nil

        basketFactory.addProduct(userId: userId, basketElement: quantity) { response in
            switch response.result {
            case .success(let response):
                addProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(addProductResult?.result, 1)
    }

    func test2AddProductIncorrectProductId() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let userId = 100
        let product = Product(
            id: -23019,
            name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            price: 2378,
            mainImage: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp")
        let quantity = BasketElement(product: product, quantity: 1)
        var addProductResult: GetBasketResult? = nil

        basketFactory.addProduct(userId: userId, basketElement: quantity) { response in
            switch response.result {
            case .success(let response):
                addProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(addProductResult?.result, 0)
    }

    func test3AddProductIncorrectQuantity() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "incorrectQuantity")
        let userId = 100
        let product = Product(
            id: 23019,
            name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            price: 2378,
            mainImage: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp")
        let quantity = BasketElement(product: product, quantity: -1)
        var addProductResult: GetBasketResult? = nil

        basketFactory.addProduct(userId: userId, basketElement: quantity) { response in
            switch response.result {
            case .success(let response):
                addProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(addProductResult?.result, 0)
    }

}
