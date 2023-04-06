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
        XCTAssertEqual(catalogResult?.result, 1)
        let productsCount = catalogResult?.products?.count
        XCTAssertEqual(productsCount, 10)
        XCTAssertEqual(catalogResult?.products?[0].id, 23019)
        XCTAssertEqual(catalogResult?.products?[0].category, "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК")
        XCTAssertEqual(catalogResult?.products?[0].name, "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.")

        let imageUrl = "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp"
        XCTAssertEqual(catalogResult?.products?[0].mainImage, imageUrl)
        XCTAssertEqual(catalogResult?.products?[0].price, 2378)

        if let productsCount, productsCount <= 20 {
            XCTAssertNil(catalogResult?.nextPage)
        } else {
            XCTAssertNotNil(catalogResult?.nextPage)
        }
    }

    func testGetCatalogIncorrectPageNumber() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        let exp = expectation(description: "incorrectPageNumber")
        let pageNumber = 0
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

        XCTAssertEqual(catalogResult?.result, 0)
        XCTAssertEqual(catalogResult?.errorMessage, "Номер страницы должен быть больше 0!")
        XCTAssertNil(catalogResult?.nextPage)
        XCTAssertNil(catalogResult?.products)
    }

    func testGetCatalogIncorrectCategoryid() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        let exp = expectation(description: "incorrectCategoryId")
        let pageNumber = 1
        let categoryId = -1
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
        XCTAssertEqual(catalogResult?.errorMessage, "Неверный идентификатор категории")
        XCTAssertNil(catalogResult?.nextPage)
        XCTAssertNil(catalogResult?.products)
    }

}
