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

    func test01EditProfileCorrectInputWithoutEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "Admin2",
            lastname: "Admin2",
            username: "adminadmin2",
            email: "",
            creditCard: "0000000000000012",
            gender: Gender.man.rawValue,
            bio: "Admin's bio")

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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test02EditProfileCorrectInputWithEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "Admin",
            lastname: "Admin",
            username: "adminadmin",
            email: "adminadmin2@adm.in",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "I'm an admin person")

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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test03EditProfileCorrectInputWithoutEmailAndPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "Admin3",
            lastname: "Admin3",
            username: "adminadmin3",
            oldPassword: "Password0000",
            newPassword: "Password1111",
            email: "",
            creditCard: "0000000000000000",
            gender: Gender.man.rawValue,
            bio: "I'm an admin3 person")

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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test04EditProfileCorrectInputWithEmailAndPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "Foo",
            lastname: "Bar",
            username: "FooBarBaz0000",
            oldPassword: "Password1111",
            newPassword: "Password2222",
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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test05EditProfileCorrectOnlyEmail() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test06EditProfileCorrectOnlyPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            oldPassword: "Password2222",
            newPassword: "Password0001",
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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test07EditProfileCorrectOnlyEmailPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "",
            lastname: "",
            username: "",
            oldPassword: "Password0001",
            newPassword: "Password0200",
            email: "adminadmin@adm.in",
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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

    func test08EditProfileInсorrectOldPassword() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectInput")
        var editResult: EditProfileResult? = nil

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
        XCTAssertEqual(editResult?.result, 0)
        XCTAssertNotNil(editResult?.errorMessage)
        XCTAssertEqual("Не удалось обновить данные, так как Вы указываете неверный email, username или пароль", editResult?.errorMessage)
    }

    func test09EditProfileIncorrectUserId() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "incorrectUserId")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: -1,
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
        XCTAssertEqual(editResult?.result, 0)
        XCTAssertNotNil(editResult?.errorMessage)
        XCTAssertEqual("Не удалось обновить данные, так как Вы указываете неверный email, username или пароль", editResult?.errorMessage)
    }

    func test10ResetCorrect() {
        let edit = requestFactory.makeEditProfileRequestFactory()
        let exp = expectation(description: "correctInput")
        var editResult: EditProfileResult? = nil

        let profile = EditProfile(
            userId: 100,
            name: "Admin",
            lastname: "Admin",
            username: "adminadmin",
            oldPassword: "Password0200",
            newPassword: "Password0000",
            email: "adminadmin@adm.in",
            creditCard: "0000000000000000",
            gender: Gender.indeterminate.rawValue,
            bio: "I'm an admin person")

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
        XCTAssertEqual(editResult?.result, 1)
        XCTAssertNil(editResult?.errorMessage)
    }

}
