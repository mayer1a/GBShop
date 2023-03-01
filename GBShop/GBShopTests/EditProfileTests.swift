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
        var result = -1
        let profile = EditUserProfile(
            id: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        edit.editProfile(profile: profile) { response in
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
        var result = -1
        let profile = EditUserProfile(
            id: -20,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")


        XCTExpectFailure("trying to logout with incorrect user id but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
        var result = -1
        let profile = EditUserProfile(
            id: 123,
            username: "самбади",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to logout with incorrect username but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
        var result = -1
        let profile = EditUserProfile(
            id: 123,
            username: "Somebody",
            password: "_Б",
            email: "some@some.ru",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to logout with incorrect password but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
        var result = -1
        let profile = EditUserProfile(
            id: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some @so",
            creditCard: "9872389-2424-234224-234",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to logout with incorrect email but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
        var result = -1
        let profile = EditUserProfile(
            id: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            creditCard: "98723B A7476",
            gender: .man,
            bio: "This is good! I think I will switch to another language")

        XCTExpectFailure("trying to logout with incorrect card number but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
        let profile = EditUserProfile(
            id: 0,
            username: "",
            password: "",
            email: "",
            creditCard: "",
            gender: .man,
            bio: "")

        XCTExpectFailure("trying to logout with empty input but edit profile was succesful")

        edit.editProfile(profile: profile) { response in
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
