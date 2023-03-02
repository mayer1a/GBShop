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
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "correctInput")
        let productId = 123
        var removeProductResult: RemoveProductResult? = nil

        basketFactory.removeProduct(productId: productId) { response in
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
    }

    func testRemoveProductIncorrectProductId() {
        let basketFactory = requestFactory.makeBasketRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = -2123
        var removeProductResult: RemoveProductResult? = nil

        XCTExpectFailure("trying to remove product from basket with incorrect product id but the product was removed")

        basketFactory.removeProduct(productId: productId) { response in
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
    }

}
