//
//  LogoutTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class LogoutTests: XCTestCase {

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

    func testLogoutCorrectId() {
        let logout = requestFactory.makeLogoutRequestFactory()
        let exp = expectation(description: "correctId")
        let userId = 123
        var result = -1

        logout.logout(userId: userId) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, 1)
    }

    func testLogoutIncorrectId() {
        let logout = requestFactory.makeLogoutRequestFactory()
        let exp = expectation(description: "incorrectId")
        let userId = -20
        var result = -1

        XCTExpectFailure("trying to logout with incorrect user id but logout was succesful")

        logout.logout(userId: userId) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, 0)
    }

}
