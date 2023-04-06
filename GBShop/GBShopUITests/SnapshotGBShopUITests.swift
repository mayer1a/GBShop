//
//  SnapshotGBShopUITests.swift
//  GBShopUITests
//
//  Created by Artem Mayer on 06.04.2023.
//

import XCTest
import UIKit
@testable import GBShop

final class SnapshotGBShopUITests: XCTestCase {

    // MARK: - Properties

    var app: XCUIApplication!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        continueAfterFailure = false

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        setupSnapshot(app)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }

    func test1SignInScreen() throws {
        try checkUserAuthState()
        let signInView = app.otherElements["signInView"].firstMatch
        XCTAssert(signInView.waitForExistence(timeout: 5))

        snapshot("01SignInScreen")

        try signUpScreen(signInView)
        try catalogScreen(signInView)
        try productScreen()
        let tabBarView = try basketScreen()
        try profileScreen(tabBarView)
    }

    func signUpScreen(_ signInView: XCUIElement) throws {
        let signUpButton = signInView.buttons["signUpButton"].firstMatch
        XCTAssert(signUpButton.exists)

        signUpButton.tap()

        let signUpView = app.otherElements["signUpView"].firstMatch
        XCTAssert(signUpView.waitForExistence(timeout: 5))

        snapshot("02SignUpScreen")

        app.navigationBars.buttons["Назад"].tap()
    }

    func catalogScreen(_ signInView: XCUIElement) throws {
        let emailTextField = signInView.textFields["emailTextField"].firstMatch
        XCTAssert(emailTextField.waitForExistence(timeout: 5))

        let passwordTextField = signInView.secureTextFields["passwordTextField"].firstMatch
        XCTAssert(passwordTextField.exists)

        let signInButton = signInView.buttons["signInButton"].firstMatch
        XCTAssert(signInButton.exists)

        emailTextField.tap()
        emailTextField.typeText("adminadmin@adm.in")

        passwordTextField.tap()
        sleep(1)
        passwordTextField.typeText("Password0000")

        signInButton.tap()

        let catalogButton = app.tabBars.firstMatch.buttons["каталог"]
        XCTAssert(catalogButton.waitForExistence(timeout: 10))

        snapshot("03CatalogScreen")
    }

    func productScreen() throws {
        let collectionView = app.collectionViews.firstMatch
        XCTAssert(collectionView.waitForExistence(timeout: 10))

        let firstProduct = collectionView.cells["0"].firstMatch
        XCTAssert(firstProduct.waitForExistence(timeout: 5))
        firstProduct.tap()

        let productView = app.otherElements["productView"].firstMatch
        XCTAssert(productView.waitForExistence(timeout: 5))

        snapshot("04ProductScreen01")

        let basketButton = productView.buttons["basketButton"].firstMatch
        XCTAssert(basketButton.waitForExistence(timeout: 5))
        basketButton.tap()

        productView.swipeUp()
        productView.swipeUp()

        try reviewsScreen(productView)

        let backButton = app.navigationBars.buttons["каталог"].firstMatch
        XCTAssert(backButton.waitForExistence(timeout: 5))

        snapshot("04ProductScreen02")

        backButton.tap()

        let secondProductButton = collectionView.cells["1"].firstMatch.buttons["basket"].firstMatch
        XCTAssert(secondProductButton.waitForExistence(timeout: 10))
        secondProductButton.tap()
    }

    func reviewsScreen(_ productView: XCUIElement) throws {
        let reviewsButton = productView.buttons["showReviewsButton"].firstMatch
        XCTAssert(reviewsButton.waitForExistence(timeout: 5))
        reviewsButton.tap()

        let backButton = app.buttons["назад"].firstMatch
        XCTAssert(backButton.waitForExistence(timeout: 5))

        snapshot("05ReviewsScreen")

        backButton.tap()
    }

    func basketScreen() throws -> XCUIElement {
        let tabBarView = app.tabBars.firstMatch
        XCTAssert(tabBarView.waitForExistence(timeout: 5))

        let profileTabButton = tabBarView.buttons["корзина"]
        XCTAssert(tabBarView.waitForExistence(timeout: 5))
        profileTabButton.tap()

        let purchaseButton = app.buttons["ОФОРМИТЬ ЗАКАЗ"].firstMatch
        XCTAssert(purchaseButton.waitForExistence(timeout: 10))

        snapshot("06BasketScreen01")

        purchaseButton.tap()

        XCTAssert(app.staticTexts["в вашей корзине пока ничего нет ..."].firstMatch.waitForExistence(timeout: 10))

        snapshot("06BasketScreen02")

        return tabBarView
    }

    func profileScreen(_ tabBarView: XCUIElement) throws {
        let profileTabButton = tabBarView.buttons["профиль"]
        XCTAssert(profileTabButton.waitForExistence(timeout: 5))
        profileTabButton.tap()

        let saveButton = app.buttons["Cохранить"].firstMatch
        print(app.buttons.debugDescription)
        XCTAssert(saveButton.waitForExistence(timeout: 10))

        snapshot("07ProfileScreen")
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
