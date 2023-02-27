//
//  GettingProductTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class GettingProductTests: XCTestCase {

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

    func testGetProductCorrectInput() {
        let product = requestFactory.makeProductGettingRequestFactory()
        let exp = expectation(description: "correctInput")
        let productId = 123
        var productResult: ProductResult? = nil

        product.getProduct(productId: productId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 4)
        XCTAssertEqual(productResult?.result, 1)
//        XCTAssertEqual(productResult?.name, "Ноутбук")
//        XCTAssertEqual(productResult?.price, 45600)
//        XCTAssertEqual(productResult?.description, "Мощный игровой ноутбук")
    }

    func testGetProductIncorrectProductId() {
        let product = requestFactory.makeProductGettingRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 123
        var productResult: ProductResult? = nil

        XCTExpectFailure("trying to get product with incorrect product id but the product was recieved")

        product.getProduct(productId: productId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 4)
        XCTAssertNil(productResult)
    }

}
