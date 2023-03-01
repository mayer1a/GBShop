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
        let username = "Somebody"
        let password = "mypassword"
        var result = -1

        signIn.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(1, result, "trying to login with username: \(username). Login not found")
    }

    func testSignInIncorrectUsername() {
        let exp1 = expectation(description: "incorrectUsername1")
        let exp2 = expectation(description: "incorrectUsername2")
        let exp3 = expectation(description: "incorrectUsername3")
        let signIn = requestFactory.makeSignInRequestFatory()
        let usernameLowLetter = "somebody"
        let usernameWithDigit = "Somebody2"
        let usernameRussian = "Самбади"
        let password = "mypassword"
        var results: [Int] = []

        XCTExpectFailure("trying to login with non-existent usernames but the usernames were found")

        signIn.login(userName: usernameLowLetter, password: password) { response in
            switch response.result {
            case .success(let login):
                results.append(login.result)
            case .failure(_):
                break
            }

            exp1.fulfill()
        }

        signIn.login(userName: usernameWithDigit, password: password) { response in
            switch response.result {
            case .success(let login):
                results.append(login.result)
            case .failure(_):
                break
            }

            exp2.fulfill()
        }

        signIn.login(userName: usernameRussian, password: password) { response in
            switch response.result {
            case .success(let login):
                results.append(login.result)
            case .failure(_):
                break
            }

            exp3.fulfill()
        }

        waitForExpectations(timeout: 6)
        XCTAssertEqual(results, [0, 0, 0])
    }

    func testSignInEmptyPassword() throws {
        let exp = expectation(description: "emptyPassword")
        let signIn = requestFactory.makeSignInRequestFatory()
        let username = "somebody"
        let password = ""
        var result = -1

        XCTExpectFailure("trying to login with an empty password but authentication was successful")

        signIn.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, 0)
    }

    func testWithIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let signIn = requestFactory.makeSignInRequestFatory()
        let username = "Somebody"
        let password = "psw1000"
        var result = -1

        XCTExpectFailure("trying to login with an incorrect password but authentication was successful")

        signIn.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)

        XCTAssertEqual(result, 0)
    }

    func testWithEmptyInput() {
        let exp = expectation(description: "emptyInput")
        let signIn = requestFactory.makeSignInRequestFatory()
        let username = ""
        let password = ""
        var result = -1

        XCTExpectFailure("trying to login with an empty login and password but authentication was successful")

        signIn.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(result, 0)
    }
}
