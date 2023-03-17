//
//  AddReviewTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 27.02.2023.
//

import XCTest
@testable import GBShop

final class AddReviewTests: XCTestCase {

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

    func testAddReviewCorrectInput() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let productId = 456
        let description = "Текст отзыва"
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, description: description) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(addReviewResult?.result, 1)
        XCTAssertEqual(addReviewResult?.userMessage, "Ваш отзыв был передан на модерацию")
    }

    func testAddReviewAnonCorrectInput() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctAnonInput")
        let userId: Int? = nil
        let productId = 456
        let description = "Текст отзыва"
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, description: description) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(addReviewResult?.result, 1)
        XCTAssertEqual(addReviewResult?.userMessage, "Ваш отзыв был передан на модерацию")
    }

    func testAddReviewIncorrectProductId() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let userId = 100
        let productId = -456
        let description = "Текст отзыва"
        var addReviewResult: AddReviewResult? = nil

        XCTExpectFailure("trying to add review with incorrect product id but the review was added")

        addReview.addReview(userId: userId, productId: productId, description: description) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(addReviewResult?.result, 0)
        XCTAssertNil(addReviewResult?.userMessage)
    }

    func testAddReviewsIncorrectUserId() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectUserId")
        let userId = -100
        let productId = 456
        let description = "Текст отзыва"
        var addReviewResult: AddReviewResult? = nil

        XCTExpectFailure("trying to add review with incorrect user id but the review was added")

        addReview.addReview(userId: userId, productId: productId, description: description) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(addReviewResult?.result, 0)
        XCTAssertNil(addReviewResult?.userMessage)
    }

}
