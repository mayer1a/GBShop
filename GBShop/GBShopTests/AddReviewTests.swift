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

    func test1AddReviewCorrectInput() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 100
        let productId = 23019
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        guard let userMessage = addReviewResult?.userMessage else {
            XCTFail("User message is nil!")
            return
        }

        XCTAssertEqual(addReviewResult?.result, 1)
        XCTAssertTrue(userMessage.contains("был передан на модерацию"))
    }

    func test2AddReviewAnonCorrectInput() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "correctAnonInput")
        let userId: Int? = nil
        let productId = 23019
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        guard let userMessage = addReviewResult?.userMessage else {
            XCTFail("User message is nil!")
            return
        }

        XCTAssertEqual(addReviewResult?.result, 1)
        XCTAssertTrue(userMessage.contains("был передан на модерацию"))
    }

    func test3AddReviewIncorrectProductId() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectProductId")
        let userId = 100
        let productId = 456
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
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
        XCTAssertEqual(addReviewResult?.userMessage, "Товара с указанным id не существует!")
    }

    func test4AddReviewsIncorrectUserId() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "incorrectUserId")
        let userId = 1
        let productId = 23019
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
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
        XCTAssertEqual(addReviewResult?.userMessage, "Пользователя с указанным id не существует!")
    }

    func test5AddExistsReview() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "addExistsReview")
        let userId = 100
        let productId = 23019
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
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
        XCTAssertEqual(addReviewResult?.userMessage, "Данный отзыв уже существует!")
    }

    func test6AddAnonExistsReview() {
        let addReview = requestFactory.makeReviewsRequestFactory()
        let exp = expectation(description: "addExistsReview")
        let userId: Int? = nil
        let productId = 23019
        let body = "Текст отзыва"
        let rating = 4
        let date = Date.timeIntervalSinceReferenceDate
        var addReviewResult: AddReviewResult? = nil

        addReview.addReview(userId: userId, productId: productId, body: body, rating: rating, date: date) { response in
            switch response.result {
            case .success(let response):
                addReviewResult = response
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        
        guard let userMessage = addReviewResult?.userMessage else {
            XCTFail("User message is nil!")
            return
        }

        XCTAssertEqual(addReviewResult?.result, 1)
        XCTAssertTrue(userMessage.contains("был передан на модерацию"))
    }

}
