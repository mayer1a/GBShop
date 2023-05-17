//
//  ApproveReviewTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 27.02.2023.
//

import XCTest
@testable import GBShop

final class ApproveReviewTests: XCTestCase {

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

    func testApproveReviewCorrectInput() {
        let approveReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let reviewId = 104
        var approveReviewResult: ApproveReviewResult? = nil

        approveReview.approveReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                approveReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(approveReviewResult?.result, 1)
    }

    func testApproveReviewIncorrectUserId() {
        let approveReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectUserId")
        let userId = 1
        let reviewId = 104
        var approveReviewResult: ApproveReviewResult? = nil

        approveReview.approveReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                approveReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(approveReviewResult?.result, 0)
        XCTAssertEqual(approveReviewResult?.errorMessage, "У Вас нет прав на одобрение отзывов!")
    }

    func testApproveReviewIncorrectReviewId() {
        let approveReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let reviewId = 1
        var approveReviewResult: ApproveReviewResult? = nil

        approveReview.approveReview(userId: userId, reviewId: reviewId) { response in
            switch response.result {
            case .success(let response):
                approveReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(approveReviewResult?.result, 0)
        XCTAssertEqual(approveReviewResult?.errorMessage, "Отзыва с заданным id не существует!")
    }

}
