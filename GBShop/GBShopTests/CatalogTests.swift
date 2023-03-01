//
//  CatalogTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class CatalogTests: XCTestCase {

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
        let catalog = requestFactory.makeCatalogRequestFactory()
        let exp = expectation(description: "correctInput")
        let pageNumber = 1
        let categoryId = 1
        var catalogResult: CatalogResult? = nil

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                catalogResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(catalogResult?.products?.count, 2)
        XCTAssertEqual(catalogResult?.products?[0].id, 123)
        XCTAssertEqual(catalogResult?.products?[0].name, "Ноутбук")
        XCTAssertEqual(catalogResult?.products?[0].price, 45600)
        XCTAssertEqual(catalogResult?.products?[1].id, 456)
        XCTAssertEqual(catalogResult?.products?[1].name, "Компьютерная мышь")
        XCTAssertEqual(catalogResult?.products?[1].price, 1000)
    }

    func testGetCatalogIncorrectPageNumber() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        let exp = expectation(description: "incorrectPageNumber")
        let pageNumber = -2
        let categoryId = 1
        var catalogResult: CatalogResult? = nil

        XCTExpectFailure("trying to get catalog with incorrect page number but the products were recieved")

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                catalogResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(catalogResult?.result, 0)
        XCTAssertNil(catalogResult?.pageNumber)
        XCTAssertNil(catalogResult?.products)
    }

    func testGetCatalogIncorrectCategoryid() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        let exp = expectation(description: "incorrectCategoryId")
        let pageNumber = 1
        let categoryId = -98
        var catalogResult: CatalogResult? = nil

        XCTExpectFailure("trying to get catalog with incorrect category id but the products were recieved")

        catalog.getCatalog(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let response):
                catalogResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(catalogResult?.result, 0)
        XCTAssertNil(catalogResult?.pageNumber)
        XCTAssertNil(catalogResult?.products)
    }

}
