//
//  SignUpTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class SignUpTests: XCTestCase {

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

    func testSignUpCorrectInput() {
        let signUp = requestFactory.makeSignUpRequestFactory()
        let exp = expectation(description: "correctInput")
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        signUp.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, result, "trying to registration")
    }

    func testSignUpIncorrectUsername() {
        let exp = expectation(description: "incorrectUsername")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "самбади",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect username but registration was succesful")

        signUp.registration(profile: profile) { response in
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

    func testSignUpIncorrectEmail() {
        let exp = expectation(description: "incorrectEmail")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some @so",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect email but registration was succesful")

        signUp.registration(profile: profile) { response in
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

    func testSignUpIncorrectCardNumber() {
        let exp = expectation(description: "incorrectCardNumber")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "987A-2424234 B224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect card number but registration was succesful")

        signUp.registration(profile: profile) { response in
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

    func testSignUpIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect password but registration was succesful")

        signUp.registration(profile: profile) { response in
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

    func testSignUpWithEmptyInput() {
        let exp = expectation(description: "emptyInput")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "",
            password: "",
            email: "",
            creditCard: "",
            gender: .man,
            bio: "")

        XCTExpectFailure("trying to registration with empty input but registration was succesful")

        signUp.registration(profile: profile) { response in
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
