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
        let userId = 123
        let reviewId = 112
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
    }

    func testRemoveReviewIncorrectUserId() {
        let removeReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = -123
        let reviewId = 112
        var removeReviewResult: RemoveReviewResult? = nil

        XCTExpectFailure("trying to remove review with incorrect user id but the review was removed")

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
    }

    func testRemoveReviewIncorrectReviewId() {
        let removeReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 123
        let reviewId = -112
        var removeReviewResult: RemoveReviewResult? = nil

        XCTExpectFailure("trying to remove review with incorrect review id but the review was removed")

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
    }

}
