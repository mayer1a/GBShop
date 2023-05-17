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
        let email = "adminadmin@adm.in"
        let password = "Password0000"
        var signInResult: SignInResult? = nil

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

        guard let user = signInResult?.user else {
            XCTFail("User is nil!")
            return
        }

        XCTAssertEqual(signInResult?.result, 1)
        XCTAssertGreaterThanOrEqual(user.id, 100)
        XCTAssertEqual(signInResult?.user?.email, email)
        XCTAssertNil(signInResult?.errorMessage)
    }

    func testSignInIncorrectEmail() {
        let exp = expectation(description: "incorrectEmail")
        let signIn = requestFactory.makeSignInRequestFatory()
        let email = "foofoobar@bar.af"
        let password = "Password0000"
        var signInResult: SignInResult? = nil

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
        XCTAssertEqual(signInResult?.result, 0)
        XCTAssertNil(signInResult?.user)
        XCTAssertNotNil(signInResult?.errorMessage)
        XCTAssertEqual(signInResult?.errorMessage, "Неверный логин или пароль")
    }

    func testSignInIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let signIn = requestFactory.makeSignInRequestFatory()
        let email = "adminadmin@adm.in"
        let password = "password0000"
        var signInResult: SignInResult? = nil

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
        XCTAssertEqual(signInResult?.result, 0)
        XCTAssertNil(signInResult?.user)
        XCTAssertNotNil(signInResult?.errorMessage)
        XCTAssertEqual(signInResult?.errorMessage, "Неверный логин или пароль")
    }
}
