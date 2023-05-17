//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 01.03.2023.
//

import XCTest
@testable import GBShop

final class PayBasketTests: XCTestCase {

    // MARK: - Properties

    var requestFactory: RequestFactory!

    // MARK: - Private properties

    lazy var firstAddingProductExp: XCTestExpectation = expectation(description: "addingProduct")
    lazy var secondAddingProductExp: XCTestExpectation = expectation(description: "addingProduct")

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    // MARK: - Functions

    func test1PayNotExistsBasket() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 101
        var payBasketResult: PayBasketResult? = nil

        basketFactory.payBasket(userId: userId) { response in
            switch response.result {
            case .success(let response):
                payBasketResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)

        XCTAssertEqual(payBasketResult?.result, 0)
        XCTAssertEqual(payBasketResult?.errorMessage, "Корзина не найдена!")
    }

    func test2PayBasketCorrect() {
        addProductToBasket()
        wait(for: [firstAddingProductExp])
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        var payBasketResult: PayBasketResult? = nil

        basketFactory.payBasket(userId: userId) { response in
            switch response.result {
            case .success(let response):
                payBasketResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)

        XCTAssertEqual(payBasketResult?.result, 1)
        XCTAssertEqual(payBasketResult?.userMessage, "Покупки успешно оплачены. Чек выслан на почту.")
    }

    func test3PayBasketIncorrect() {
        addProductToBasket(40)
        wait(for: [secondAddingProductExp])
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "canceledPurchaseDueMoneyLack")
        let userId = 100
        var payBasketResult: PayBasketResult? = nil

        basketFactory.payBasket(userId: userId) { response in
            switch response.result {
            case .success(let response):
                payBasketResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)

        XCTAssertEqual(payBasketResult?.result, -1)
        XCTAssertEqual(payBasketResult?.errorMessage, "Отказ со стороны банка!")
    }

    // MARK: - Private functions
    
    private func addProductToBasket(_ productQuantity: Int = 1) {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")

        let product = Product(
            id: 23019,
            name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            price: 2378,
            mainImage: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp")
        let basketElement = BasketElement(product: product, quantity: productQuantity)
        var addProductResult: GetBasketResult? = nil

        clearBasket()

        basketFactory.addProduct(userId: 100, basketElement: basketElement) { response in
            switch response.result {
            case .success(let response):
                addProductResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)

        XCTAssertEqual(addProductResult?.result, 1)
        if productQuantity == 1 {
            firstAddingProductExp.fulfill()
        } else {
            secondAddingProductExp.fulfill()
        }
    }

    private func clearBasket() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let clearExp = expectation(description: "basketClear")

        basketFactory.removeProduct(userId: 100, productId: 23019) { response in
            switch response.result {
            case .success(_):
                clearExp.fulfill()
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }
        }

        wait(for: [clearExp], timeout: 10)
    }
}
