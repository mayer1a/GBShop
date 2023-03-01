//
//  RegistrationTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class RegistrationTests: XCTestCase {

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

    func testRegCorrectInput() {
        let reg = requestFactory.makeRegistrationRequestFactory()
        let exp = expectation(description: "correctInput")
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(1, result, "trying to registration")
    }

    func testRegIncorrectUsername() {
        let exp = expectation(description: "incorrectUsername")
        let reg = requestFactory.makeRegistrationRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "самбади",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect username but registration was succesful")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }

    func testRegIncorrectEmail() {
        let exp = expectation(description: "incorrectEmail")
        let reg = requestFactory.makeRegistrationRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some @so",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect email but registration was succesful")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }

    func testRegIncorrectCardNumber() {
        let exp = expectation(description: "incorrectCardNumber")
        let reg = requestFactory.makeRegistrationRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "987A-2424234 B224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect card number but registration was succesful")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }

    func testRegIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let reg = requestFactory.makeRegistrationRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "Somebody",
            password: "",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to registration with incorrect password but registration was succesful")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }

    func testRegWithEmptyInput() {
        let exp = expectation(description: "emptyInput")
        let reg = requestFactory.makeRegistrationRequestFactory()
        var result = -1
        let profile = SignUpUser(
            username: "",
            password: "",
            email: "",
            creditCard: "",
            gender: .man,
            bio: "")

        XCTExpectFailure("trying to registration with empty input but registration was succesful")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let response):
                result = response.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }
}
