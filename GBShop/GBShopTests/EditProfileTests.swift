//
//  EditProfileTests.swift
//  GBShopTests
//
//  Created by Artem Mayer on 16.02.2023.
//

import XCTest
@testable import GBShop

final class EditProfileTests: XCTestCase {

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

    func testEditProfileCorrectInput() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        edit.editProfile(
            userId: userId,
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
        XCTAssertEqual(result, 1)
    }

    func testEditProfileIncorrectUserId() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        let userId = -20
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to logout with incorrect user id but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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

    func testEditProfileIncorrectUsername() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectUsername")
        let userId = 123
        let username = "самбади"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to logout with incorrect username but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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

    func testEditProfileIncorrectPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectPassword")
        let userId = 123
        let username = "Somebody"
        let password = "_Б"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to logout with incorrect password but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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

    func testEditProfileIncorrectEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectEmail")
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some @so"
        let gender = "m"
        let creditCardNumber = "9872389-2424-234224-234"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to logout with incorrect email but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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

    func testEditProfileIncorrectCardNumber() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectCardNumber")
        let userId = 123
        let username = "Somebody"
        let password = "mypassword"
        let email = "some@some.ru"
        let gender = "m"
        let creditCardNumber = "98723B A7476"
        let aboutMe = "This is good! I think I will switch to another language"
        var result = -1

        XCTExpectFailure("trying to logout with incorrect card number but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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

    func testEditProfileEmptyInput() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "emptyInput")
        let userId = Int()
        let username = ""
        let password = ""
        let email = ""
        let gender = ""
        let creditCardNumber = ""
        let aboutMe = ""
        var result = -1

        XCTExpectFailure("trying to logout with empty input but edit profile was succesful")

        edit.editProfile(
            userId: userId,
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
