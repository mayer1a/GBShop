//
//  CatalogGettingTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class CatalogGettingTests: XCTestCase {

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

    func testGetCatalogCorrectInput() {
        let catalog = requestFactory.makeCatalogGettingRequestFactory()
        let exp = expectation(description: "correctInput")
        let pageNumber = 1
        let categoryId = 1
        var productResult: [Product] = []

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 4)
        XCTAssertEqual(productResult.count, 2)
        XCTAssertEqual(productResult[0].id, 123)
        XCTAssertEqual(productResult[0].productName, "Ноутбук")
        XCTAssertEqual(productResult[0].price, 45600)
        XCTAssertEqual(productResult[1].id, 456)
        XCTAssertEqual(productResult[1].productName, "Мышка")
        XCTAssertEqual(productResult[1].price, 1000)
    }

    func testGetCatalogIncorrectPageNumber() {
        let catalog = requestFactory.makeCatalogGettingRequestFactory()
        let exp = expectation(description: "incorrectPageNumber")
        let pageNumber = -2
        let categoryId = 1
        var productResult: [Product] = []

        XCTExpectFailure("trying to get catalog with incorrect page number but the products were recieved")

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 4)
        XCTAssertEqual(productResult.count, 0)
    }

    func testGetCatalogIncorrectCategoryid() {
        let catalog = requestFactory.makeCatalogGettingRequestFactory()
        let exp = expectation(description: "incorrectCategoryId")
        let pageNumber = 1
        let categoryId = -98
        var productResult: [Product] = []

        XCTExpectFailure("trying to get catalog with incorrect category id but the products were recieved")

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                productResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 4)
        XCTAssertEqual(productResult.count, 0)
    }

}
