//
//  SignInTests.swift
//  AuthTests
//
//  Created by Artem Mayer on 11.02.2023.
//

import XCTest
@testable import GBShop

final class SignInTests: XCTestCase {

    // MARK: - Properties

    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testSignInCorrectInput() {
        let signIn = requestFactory.makeSignInRequestFatory()
        let exp = expectation(description: "correctInput")
        let email = "foobar@baz.az"
        let password = "FooBarBaz0000"
        var signInResult = SignInResult(result: -1, user: nil, errorMessage: nil)

        signIn.login(email: email, password: password) { response in
            switch response.result {
            case .success(let result):
                signInResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
                return
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
        XCTAssertEqual(1, signInResult.result, "Email not found")
        XCTAssertNotNil(signInResult.user, "Email not found")
        XCTAssertEqual(100, signInResult.user?.id, "Email not found")
        XCTAssertNil(signInResult.errorMessage, "Email not found")
    }

    func testSignInIncorrectEmail() {
        let exp = expectation(description: "incorrectEmail")
        let signIn = requestFactory.makeSignInRequestFatory()
        let email = "foofoobar@bar.af"
        let password = "FooBarBaz0000"
        var signInResult = SignInResult(result: -1, user: nil, errorMessage: nil)

        signIn.login(email: email, password: password) { response in
            switch response.result {
            case .success(let result):
                signInResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 6)
        XCTAssertEqual(0, signInResult.result)
        XCTAssertNil(signInResult.user)
        XCTAssertNotNil(signInResult.errorMessage)
        XCTAssertEqual("Неверный логин или пароль", signInResult.errorMessage)
    }

    func testSignInIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let signIn = requestFactory.makeSignInRequestFatory()
        let email = "foobar@baz.az"
        let password = "BarBar0000"
        var signInResult = SignInResult(result: -1, user: nil, errorMessage: nil)

        signIn.login(email: email, password: password) { response in
            switch response.result {
            case .success(let result):
                signInResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 6)
        XCTAssertEqual(0, signInResult.result)
        XCTAssertNil(signInResult.user)
        XCTAssertNotNil(signInResult.errorMessage)
        XCTAssertEqual("Неверный логин или пароль", signInResult.errorMessage)
    }
}
