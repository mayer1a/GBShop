//
//  RemoveReviewTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 27.02.2023.
//

import XCTest
@testable import GBShop

final class RemoveReviewTests: XCTestCase {

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

    func testRemoveReviewCorrectInput() {
        let removeReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let reviewId = 104
        var removeReviewResult: RemoveReviewResult? = nil

        removeReview.removeReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                removeReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(removeReviewResult?.result, 1)
        XCTAssertNil(removeReviewResult?.errorMessage)
    }

    func testRemoveReviewIncorrectAccess() {
        let removeReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 101
        let reviewId = 105
        var removeReviewResult: RemoveReviewResult? = nil

        removeReview.removeReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                removeReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(removeReviewResult?.result, 0)
        XCTAssertEqual(removeReviewResult?.errorMessage, "У Вас нет прав на удаление отзывов!")
    }

    func testRemoveReviewIncorrectReviewId() {
        let removeReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let reviewId = 1
        var removeReviewResult: RemoveReviewResult? = nil

        removeReview.removeReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                removeReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(removeReviewResult?.result, 0)
        XCTAssertEqual(removeReviewResult?.errorMessage, "Отзыва с заданным id не существует!")
    }

}
