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
        app.launchArguments = ["enable-testing"]
        app.launch()
        try checkUserAuthState()
    }

    func test1SignInFailure() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.waitForExistence(timeout: 5))

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
        signInButton.tap()

        let warningLabel = app.staticTexts["warningLabel"].firstMatch
        XCTAssert(warningLabel.waitForExistence(timeout: 5))
    }

    func test2SignUpFailure() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.waitForExistence(timeout: 5))

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        signUpButton.tap()

        let signUpView = app.otherElements["signUpView"].firstMatch
        XCTAssert(signUpView.waitForExistence(timeout: 5))

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

    func test3SignUpSuccess() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.waitForExistence(timeout: 5))

        let signUpButton = startAppElement.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        signUpButton.tap()

        let signUpView = app.otherElements["signUpView"].firstMatch
        XCTAssert(signUpView.waitForExistence(timeout: 5))

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

        let catalogButton = app.tabBars.firstMatch.buttons["каталог"]
        XCTAssert(catalogButton.waitForExistence(timeout: 10))
    }

    func test4SignInSuccess() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch
        XCTAssert(startAppElement.waitForExistence(timeout: 5))

        let emailTextField = startAppElement.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.exists)

        let passwordTextField = startAppElement.secureTextFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let signInButton = startAppElement.buttons["signInButton"].firstMatch
        XCTAssert(signInButton.exists)

        emailTextField.tap()
        emailTextField.typeText("adminadmin@adm.in")
        passwordTextField.tap()
        passwordTextField.typeText("Password0000")
        signInButton.tap()
        
        let catalogButton = app.tabBars.firstMatch.buttons["каталог"]
        XCTAssert(catalogButton.waitForExistence(timeout: 10))
    }

    // MARK: - Private functions

    private func checkUserAuthState() throws {
        let startAppElement = app.otherElements["signInView"].firstMatch

        if !startAppElement.waitForExistence(timeout: 2) {
            try logout()
        }
    }

    private func logout() throws {
        let startAppElement = app.tabBars.firstMatch
        XCTAssert(startAppElement.exists)

        let profileTabButton = startAppElement.buttons["профиль"]
        XCTAssert(startAppElement.waitForExistence(timeout: 5))
        profileTabButton.tap()

        let profileScreen = app.otherElements["profileView"].firstMatch
        XCTAssert(profileScreen.waitForExistence(timeout: 5))

        let logoutButton = app.buttons["logoutButton"].firstMatch
        XCTAssert(logoutButton.waitForExistence(timeout: 5))
        logoutButton.tap()

        print(profileScreen.debugDescription)
    }
}
