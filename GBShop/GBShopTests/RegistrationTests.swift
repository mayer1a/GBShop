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
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
        let username = "самбади"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to registration with incorrect username but registration was succesful")

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
        let username = "Somebody"
        let password = "mypassword"
        let email = "some @so"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to registration with incorrect email but registration was succesful")

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "987A-2424234 B224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to registration with incorrect card number but registration was succesful")

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
        let username = "Somebody"
        let password = ""
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to registration with incorrect password but registration was succesful")

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
        let username = ""
        let password = ""
        let email = ""
        let gender = ""
        let creditCardNumber = ""
        let aboutMe = ""
        var result = -1

        XCTExpectFailure("trying to registration with empty input but registration was succesful")

        reg.registration(
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCardNumber: creditCardNumber,
            aboutMe: aboutMe
        ) { response in
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
