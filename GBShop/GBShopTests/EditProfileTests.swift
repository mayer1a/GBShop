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

    func testEditProfileCorrectInputWithoutEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "Foo",
            lastname: "Bar",
            username: "FooBarBaz0000",
            email: "",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foo bar baz bio")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectInputWithEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "Foo",
            lastname: "Bar",
            username: "FooBarBaz0000",
            email: "foobar@baz.ah",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foo bar baz bio")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectInputWithoutEmailAndPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "Foo",
            lastname: "Bar",
            username: "FooBarBaz0000",
            oldPassword: "FooBarBaz0000",
            newPassword: "BazFooBar0000",
            email: "",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foo bar baz bio")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectInputWithEmailAndPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "Foo",
            lastname: "Bar",
            username: "FooBarBaz0000",
            oldPassword: "BazFooBar0000",
            newPassword: "FooBarBaz0000",
            email: "foobar@baz.al",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "Foo bar baz bio")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectOnlyEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            email: "foobar@baz.am",
            creditCard: "",
            gender: Gender.indeterminate.rawValue,
            bio: "")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectOnlyPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            oldPassword: "FooBarBaz0000",
            newPassword: "BazFooBar0000",
            email: "",
            creditCard: "",
            gender: Gender.indeterminate.rawValue,
            bio: "")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileCorrectOnlyEmailPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            oldPassword: "BazFooBar0000",
            newPassword: "FooBarBaz0000",
            email: "foobar@baz.ar",
            creditCard: "",
            gender: Gender.indeterminate.rawValue,
            bio: "")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, editResult.result)
        XCTAssertNil(editResult.errorMessage)
    }

    func testEditProfileInCorrectOldPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectInput")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            oldPassword: "BazFooBar0000",
            newPassword: "FooBarBaz0000",
            email: "",
            creditCard: "",
            gender: Gender.indeterminate.rawValue,
            bio: "")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(0, editResult.result)
        XCTAssertNotNil(editResult.errorMessage)
        XCTAssertEqual("Не удалось обновить данные, так как Вы указываете неверный email, username или пароль", editResult.errorMessage)
    }

    func testEditProfileInCorrectUserId() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectUserId")
        var editResult = EditProfileResult(result: -1, errorMessage: nil)

        let profile = EditProfile(
            userId: -100,
            name: "",
            lastname: "",
            username: "",
            email: "",
            creditCard: "",
            gender: Gender.indeterminate.rawValue,
            bio: "")

        edit.editProfile(profile: profile) { response in
            switch response.result {
            case .success(let result):
                editResult = result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(0, editResult.result)
        XCTAssertNotNil(editResult.errorMessage)
        XCTAssertEqual("Не удалось обновить данные, так как Вы указываете неверный email, username или пароль", editResult.errorMessage)
    }

}
