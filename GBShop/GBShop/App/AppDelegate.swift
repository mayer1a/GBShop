//
//  AppDelegate.swift
//  GBShop
//
//  Created by Artem Mayer on 11.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    let requestFactory = RequestFactory()

    // MARK: - Functions

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        testRequests()

        return true
    }

    private func testRequests() {
        authRequest()
        regRequest()
        editRequest()
        logoutRequest()
    }

    // MARK: - Registration request

    private func regRequest() {
        let reg = requestFactory.makeRegistrationRequestFactory()

        reg.registration(
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCardNumber: "9872389-2424-234224-234",
            aboutMe: "This is good! I think I will switch to another language"
        ) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Authorization request

    private func authRequest() {
        let auth = requestFactory.makeAuthRequestFatory()

        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Edit profile request

    private func editRequest() {
        let edit = requestFactory.makeEditProfileRequestFactory()

        edit.editProfile(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCardNumber: "9872389-2424-234224-234",
            aboutMe:"This is good! I think I will switch to another language"
        ) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Logout request

    private func logoutRequest() {
        let logout = requestFactory.makeLogoutRequestFactory()

        logout.logout(userId: 123) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

