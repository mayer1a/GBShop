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
        var signUpResult = SignUpResult(result: -1, userId: -1, userMessage: "")
        let profile = SignUpUser(
            name: "Foo",
            lastname: "Bar",
            username: "foobarbaz",
            password: "FooBarBaz0000",
            email: "foobar@baz.az",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foo bar baz bio")

        signUp.registration(profile: profile) { response in
            switch response.result {
            case .success(let result):
                signUpResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, signUpResult.result, "trying to registration")
        XCTAssertEqual("Регистрация прошла успешно!", signUpResult.userMessage, "trying to registration")
        XCTAssertNotEqual(-1, signUpResult.userId, "trying to registration")
    }

    func testSignUpWithExistsEmail() {
        let exp = expectation(description: "existsEmail")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var signUpResult = SignUpResult(result: -1, userId: -1, userMessage: "")
        let profile = SignUpUser(
            name: "Bar",
            lastname: "Foob",
            username: "bazbarbaz0",
            password: "FooBarBaz0000",
            email: "foobar@baz.az",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foob baz baz bio")

        signUp.registration(profile: profile) { response in
            switch response.result {
            case .success(let result):
                signUpResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(0, signUpResult.result)
        XCTAssertEqual("Регистрация завершилась отказом! Введённый email и/или username уже существуют", signUpResult.userMessage)
        XCTAssertNil(signUpResult.userId)
    }

    func testSignUpWithExistsUsername() {
        let exp = expectation(description: "existsUsername")
        let signUp = requestFactory.makeSignUpRequestFactory()
        var signUpResult = SignUpResult(result: -1, userId: -1, userMessage: "")
        let profile = SignUpUser(
            name: "Baz",
            lastname: "Barb",
            username: "foobarbaz",
            password: "FooBarBaz0000",
            email: "foobaz@bar.ar",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Barb foo baz bio")

        signUp.registration(profile: profile) { response in
            switch response.result {
            case .success(let result):
                signUpResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(0, signUpResult.result)
        XCTAssertEqual("Регистрация завершилась отказом! Введённый email и/или username уже существуют", signUpResult.userMessage)
        XCTAssertNil(signUpResult.userId)
    }
}
