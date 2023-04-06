//
//  RemoveProductTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 01.03.2023.
//

import XCTest
@testable import GBShop

final class RemoveProductTests: XCTestCase {

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

    func testRemoveProductCorrectInput() {
        addProductToBasketBeforeStart()
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        let productId = 23019
        let userId = 100
        var removeProductResult: GetBasketResult? = nil

        basketFactory.removeProduct(userId: userId, productId: productId) { response in
            switch response.result {
            case .success(let response):
                removeProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(removeProductResult?.result, 1)
        XCTAssertNil(removeProductResult?.errorMessage)
        let isContainsProduct = removeProductResult?.basket?.products.contains { $0.product.id == productId }
        XCTAssertEqual(isContainsProduct, false)
    }

    func testRemoveProductIncorrectProductId() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 1
        let userId = 100
        var removeProductResult: GetBasketResult? = nil

        basketFactory.removeProduct(userId: userId, productId: productId) { response in
            switch response.result {
            case .success(let response):
                removeProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(removeProductResult?.result, 0)
        XCTAssertEqual(removeProductResult?.errorMessage, "Товар отсутствует в корзине!")
    }

    // MARK: - Private funcctions

    private func addProductToBasketBeforeStart() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "incorrectProductId")

        let product = Product(
            id: 23019,
            name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            price: 2378,
            mainImage: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp")

        let basketElement = BasketElement(product: product, quantity: 2)
        basketFactory.addProduct(userId: 100, basketElement: basketElement) { response in
            switch response.result {
            case .success(let response):
                guard response.result == 1 else {
                    XCTFail("Product add to basket ERROR!")
                    return
                }
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }

}
