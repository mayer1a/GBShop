//
//  ReviewsTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 27.02.2023.
//

import XCTest
@testable import GBShop

final class ReviewsTests: XCTestCase {

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

    func testGetReviewsCorrectInput() {
        let reviews = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let productId = 23019
        let pageNumber = 1
        var reviewResult: ReviewsResult? = nil

        reviews.getReviews(productId: productId, pageNumber: pageNumber) { response in
            switch response.result {
            case .success(let response):
                reviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(reviewResult?.result, 1)
        XCTAssertNotNil(reviewResult?.reviews)
        XCTAssertEqual(reviewResult?.reviews?.isEmpty, false)
    }

    func testGetReviewsIncorrectProductId() {
        let reviews = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 1
        let pageNumber = 1
        var reviewResult: ReviewsResult? = nil

        reviews.getReviews(productId: productId, pageNumber: pageNumber) { response in
            switch response.result {
            case .success(let response):
                reviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(reviewResult?.result, 0)
        XCTAssertNil(reviewResult?.reviews)
        XCTAssertEqual(reviewResult?.errorMessage, "Запрашиваемый товар не найден!")
    }

    func testGetReviewsIncorrectPageNumber() {
        let reviews = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 23019
        let pageNumber = -1
        var reviewResult: ReviewsResult? = nil

        reviews.getReviews(productId: productId, pageNumber: pageNumber) { response in
            switch response.result {
            case .success(let response):
                reviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(reviewResult?.result, 0)
        XCTAssertNil(reviewResult?.reviews)
        XCTAssertEqual(reviewResult?.errorMessage, "Отзывы не найдены. Неверный номер страницы!")
    }

}
