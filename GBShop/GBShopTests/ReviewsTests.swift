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
        let productId = 456
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
        XCTAssertEqual(reviewResult?.reviews?.count, 2)

        XCTAssertEqual(reviewResult?.reviews?[0].id, 111)
        XCTAssertEqual(reviewResult?.reviews?[0].productId, 456)
        XCTAssertEqual(reviewResult?.reviews?[0].userId, 123)
        XCTAssertEqual(reviewResult?.reviews?[0].description, "Хорошая мышь")

        XCTAssertEqual(reviewResult?.reviews?[1].id, 112)
        XCTAssertEqual(reviewResult?.reviews?[1].productId, 456)
        XCTAssertNil(reviewResult?.reviews?[1].userId)
        XCTAssertEqual(reviewResult?.reviews?[1].description, "Стоит своих денег!")
    }

    func testGetReviewsIncorrectProductId() {
        let reviews = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = -123
        let pageNumber = 1
        var reviewResult: ReviewsResult? = nil

        XCTExpectFailure("trying to get reviews with incorrect product id but the reviews were recieved")

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
    }

    func testGetReviewsIncorrectPageNumber() {
        let reviews = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let productId = 456
        let pageNumber = -1
        var reviewResult: ReviewsResult? = nil

        XCTExpectFailure("trying to get reviews with incorrect page number but the reviews were recieved")

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
    }

}
