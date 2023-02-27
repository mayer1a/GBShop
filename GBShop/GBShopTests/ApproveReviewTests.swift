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
        let approveReview = requestFactory.makeApproveReviewRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 123
        let reviewId = 112
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
        let approveReview = requestFactory.makeApproveReviewRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = -123
        let reviewId = 112
        var approveReviewResult: ApproveReviewResult? = nil

        XCTExpectFailure("trying to approve review with incorrect user id but the review was approved")

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
    }

    func testApproveReviewIncorrectReviewId() {
        let approveReview = requestFactory.makeApproveReviewRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 123
        let reviewId = -112
        var approveReviewResult: ApproveReviewResult? = nil

        XCTExpectFailure("trying to approve review with incorrect review id but the review was approved")

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
    }

}
