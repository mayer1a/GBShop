//
//  AuthTests.swift
//  AuthTests
//
//  Created by Artem Mayer on 11.02.2023.
//

import XCTest
@testable import GBShop

final class AuthTests: XCTestCase {

    // MARK: - Properties

    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testAuthCorrectInput() {
        let auth = requestFactory.makeAuthRequestFatory()
        let exp = expectation(description: "correctInput")
        let username = "Somebody"
        let password = "mypassword"
        var result = -1

        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(let error):
                XCTFail("Connection or server error with description: \(error.localizedDescription)")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(1, result, "trying to login with username: \(username). Login not found")
    }

    func testAuthIncorrectUsername() {
        let exp1 = expectation(description: "incorrectUsername1")
        let exp2 = expectation(description: "incorrectUsername2")
        let exp3 = expectation(description: "incorrectUsername3")
        let auth = requestFactory.makeAuthRequestFatory()
        let usernameLowLetter = "somebody"
        let usernameWithDigit = "Somebody2"
        let usernameRussian = "Самбади"
        let password = "mypassword"
        var results: [Int] = []

        XCTExpectFailure("trying to login with non-existent usernames but the usernames were found")

        auth.login(userName: usernameLowLetter, password: password) { response in
            switch response.result {
            case .success(let login):
                results.append(login.result)
            case .failure(_):
                break
            }

            exp1.fulfill()
        }

        auth.login(userName: usernameWithDigit, password: password) { response in
            switch response.result {
            case .success(let login):
                results.append(login.result)
            case .failure(_):
                break
            }

            exp2.fulfill()
        }

        auth.login(userName: usernameRussian, password: password) { response in
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

    func testAuthEmptyPassword() throws {
        let exp = expectation(description: "emptyPassword")
        let auth = requestFactory.makeAuthRequestFatory()
        let username = "somebody"
        let password = ""
        var result = -1

        XCTExpectFailure("trying to login with an empty password but authentication was successful")

        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }

    func testWithIncorrectPassword() {
        let exp = expectation(description: "incorrectPassword")
        let auth = requestFactory.makeAuthRequestFatory()
        let username = "Somebody"
        let password = "psw1000"
        var result = -1

        XCTExpectFailure("trying to login with an incorrect password but authentication was successful")

        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)

        XCTAssertEqual(result, 0)
    }

    func testWithEmptyInput() {
        let exp = expectation(description: "emptyInput")
        let auth = requestFactory.makeAuthRequestFatory()
        let username = ""
        let password = ""
        var result = -1

        XCTExpectFailure("trying to login with an empty login and password but authentication was successful")

        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                result = login.result
            case .failure(_):
                break
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
        XCTAssertEqual(result, 0)
    }
}
