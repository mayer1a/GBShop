//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Artem Mayer on 11.02.2023.
//

import XCTest
import UIKit
@testable import GBShop

final class GBShopUITests: XCTestCase {

    var app: XCUIApplication!

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        sleep(1)
    }

    func testSignInFailure() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.exists)

        let emailTextField = startAppElement.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.exists)

        let passwordTextField = startAppElement.secureTextFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let signInButton = startAppElement.buttons["signInButton"].firstMatch
        XCTAssert(signInButton.exists)

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        emailTextField.tap()
        emailTextField.typeText("foobar@foob.bar")
        passwordTextField.tap()
        passwordTextField.typeText("Foofoobar0000")
        signInButton.tap()

        let warningLabel = app.staticTexts["warningLabel"].firstMatch
        XCTAssert(warningLabel.waitForExistence(timeout: 5))
    }

    func testSignUpFailure() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.exists)

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        signUpButton.tap()

        let signUpView = app.otherElements["signUpView"].firstMatch
        XCTAssert(signUpView.waitForExistence(timeout: 10))

        let nameTextField = signUpView.textFields["nameTextField"].firstMatch
        XCTAssert(nameTextField.exists)

        let lastnameTextField = signUpView.textFields["lastnameTextField"].firstMatch
        XCTAssert(lastnameTextField.exists)

        let usernameTextField = signUpView.textFields["usernameTextField"].firstMatch
        XCTAssert(usernameTextField.exists)

        let emailTextField = signUpView.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.exists)

        let passwordTextField = signUpView.secureTextFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let repeatPasswordTextField = signUpView.secureTextFields["repeatPasswordTextField"].firstMatch
        XCTAssert(repeatPasswordTextField.exists)

        let genderControl = signUpView.segmentedControls["genderControl"].firstMatch
        XCTAssert(genderControl.exists)

        let cardNumberTextField = signUpView.textFields["cardNumberTextField"].firstMatch
        XCTAssert(cardNumberTextField.exists)

        let bioTextField = signUpView.textFields["bioTextField"].firstMatch
        XCTAssert(bioTextField.exists)

        let signUpButtonSignUpView = signUpView.buttons["signUpButtonSignUpView"].firstMatch
        XCTAssert(signUpButtonSignUpView.exists)

        nameTextField.tap()
        nameTextField.typeText("Foo")

        lastnameTextField.tap()
        lastnameTextField.typeText("Bar")

        usernameTextField.tap()
        usernameTextField.typeText("foobarbaz")

        emailTextField.tap()
        emailTextField.typeText("foobar@foob.bar")

        passwordTextField.tap()
        passwordTextField.typeText("Password0000")

        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("")

        let indeterminateButton = genderControl.buttons["Другой"].firstMatch
        XCTAssert(signUpButtonSignUpView.exists)
        indeterminateButton.tap()

        cardNumberTextField.tap()
        cardNumberTextField.typeText("0000000000000000")

        bioTextField.tap()
        bioTextField.typeText("Foo bar baz 2!")

        signUpButtonSignUpView.tap()

        let warningLabel = app.staticTexts["warningLabel"].firstMatch
        XCTAssert(warningLabel.waitForExistence(timeout: 10))
    }

    func testSignUpSuccess() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.exists)

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        signUpButton.tap()

        let signUpView = app.otherElements["signUpView"].firstMatch
        XCTAssert(signUpView.waitForExistence(timeout: 10))

        let nameTextField = signUpView.textFields["nameTextField"].firstMatch
        XCTAssert(nameTextField.exists)

        let lastnameTextField = signUpView.textFields["lastnameTextField"].firstMatch
        XCTAssert(lastnameTextField.exists)

        let usernameTextField = signUpView.textFields["usernameTextField"].firstMatch
        XCTAssert(usernameTextField.exists)

        let emailTextField = signUpView.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.exists)

        let passwordTextField = signUpView.textFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let repeatPasswordTextField = signUpView.textFields["repeatPasswordTextField"].firstMatch
        XCTAssert(repeatPasswordTextField.exists)

        let genderControl = signUpView.segmentedControls["genderControl"].firstMatch
        XCTAssert(genderControl.exists)

        let cardNumberTextField = signUpView.textFields["cardNumberTextField"].firstMatch
        XCTAssert(cardNumberTextField.exists)

        let bioTextField = signUpView.textFields["bioTextField"].firstMatch
        XCTAssert(bioTextField.exists)

        let signUpButtonSignUpView = signUpView.buttons["signUpButtonSignUpView"].firstMatch
        XCTAssert(signUpButtonSignUpView.exists)

        nameTextField.tap()
        nameTextField.typeText("Foo")

        lastnameTextField.tap()
        lastnameTextField.typeText("Bar")

        usernameTextField.tap()
        usernameTextField.typeText("foobarbaz")

        emailTextField.tap()
        emailTextField.typeText("foobar@foob.bar")

        passwordTextField.tap()
        passwordTextField.typeText("Password0000")

        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("Password0000")

        cardNumberTextField.tap()
        cardNumberTextField.typeText("0000000000000000")

        let indeterminateButton = genderControl.buttons["Другой"].firstMatch
        XCTAssert(signUpButtonSignUpView.exists)
        indeterminateButton.tap()

        bioTextField.tap()
        bioTextField.typeText("Foo bar baz 2!")

        signUpView.tap()
        signUpButtonSignUpView.tap()

        let warningLabel = app.staticTexts["warningLabel"].firstMatch
        XCTAssertFalse(warningLabel.waitForExistence(timeout: 10))
    }

    func testSignInSuccess() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.exists)

        let emailTextField = startAppElement.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.exists)

        let passwordTextField = startAppElement.secureTextFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let signInButton = startAppElement.buttons["signInButton"].firstMatch
        XCTAssert(signInButton.exists)

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        emailTextField.tap()
        emailTextField.typeText("foobar@foob.bar")
        passwordTextField.tap()
        passwordTextField.typeText("Password0000")
        signUpButton.tap()

        let warningLabel = app.staticTexts["warningLabel"].firstMatch
        XCTAssertFalse(warningLabel.waitForExistence(timeout: 10))
    }
}
