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

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    // MARK: - Functions

    func testPayBasketCorrect() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        var payBasketResult: PayBasketResult? = nil

        basketFactory.payBasket { response in
            switch response.result {
            case .success(let response):
                payBasketResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        let correctUserMessageAnswer = "Вы успешно оплатили покупки! Детальная информация выслана на Вашу почту"

        XCTAssertEqual(payBasketResult?.result, 1)
        XCTAssertEqual(payBasketResult?.userMessage, correctUserMessageAnswer)
    }

    func testPayBasketIncorrect() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "canceledPurchaseDueMoneyLack")
        var payBasketResult: PayBasketResult? = nil

        XCTExpectFailure("trying to pay for a basket with insufficient money on the card but the purchase was paid")

        basketFactory.payBasket { response in
            switch response.result {
            case .success(let response):
                payBasketResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        let correctUserMessageAnswer = "Оплата покупки завершилась отказом"

        XCTAssertEqual(payBasketResult?.result, 0)
        XCTAssertEqual(payBasketResult?.userMessage, correctUserMessageAnswer)
    }

}
