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
//        regRequest()
//        authRequest()
//        editRequest()
//        logoutRequest()
//        getCatalog()
//        getProduct()
//        getReviews()
//        addReview()
//        approveReview()
//        removeReview()
//        addProductToBasket()
//        removeProductFromBasket()
//        payBasket()
    }

    // MARK: - Registration request

    private func regRequest() {
        let reg = requestFactory.makeSignUpRequestFactory()

        let profile = SignUpUser(
            name: "John",
            lastname: "Doe",
            username: "somebody",
            password: "Mypassword0000",
            email: "some@some.ru",
            creditCard: "9872-2424-2342-2340",
            gender: Gender.man.rawValue,
            bio: "This is good! I think I will switch to another language")

        reg.registration(profile: profile) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Authorization request

    private func authRequest(email: String = "some@some.ru", password: String = "Mypassword0000") {
        let auth = requestFactory.makeSignInRequestFatory()

        auth.login(email: email, password: password) { response in
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
        
//        let profile = EditProfile(
//            userId: 100,
//            name: "John",
//            lastname: "Doe",
//            username: "somebody2",
//            oldPassword: "Mypassword0000",
//            newPassword: "Mypassword9882",
//            email: "s0me2@some.ru",
//            creditCard: "9872-2424-2342-2342",
//            gender: .man,
//            bio: "This is good! I think I will switch to another language")

//        let profile2 = EditProfile(
//            userId: 100,
//            name: "Foo",
//            lastname: "Bar",
//            username: "foobarbaz",
//            email: "foobarbaz@foob.bar",
//            creditCard: "9872-2424-2342-2242",
//            gender: .man,
//            bio: "Test fot test")

//        let profile3 = EditProfile(
//            userId: 100,
//            name: "",
//            lastname: "",
//            username: "foobarbaz",
//            oldPassword: "Mypassword9882",
//            newPassword: "Mypassword0000",
//            email: "",
//            creditCard: "",
//            gender: .man,
//            bio: "")

//        edit.editProfile(profile: profile) { [weak self] response in
//            switch response.result {
//            case .success(let login):
//                print(login)
//                self?.authRequest(email: "s0me2@some.ru", password: "Mypassword9882")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }

//        edit.editProfile(profile: profile2) { [weak self] response in
//            switch response.result {
//            case .success(let editResponse):
//                print(editResponse)
//                self?.authRequest(email: "foobarbaz@foob.bar", password: "Mypassword9882")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }

//        edit.editProfile(profile: profile3) { [weak self] response in
//            switch response.result {
//            case .success(let login):
//                print(login)
//                self?.authRequest(email: "foobarbaz@foob.bar", password: "Mypassword0000")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }

    // MARK: - Logout request

    private func logoutRequest() {
        let logout = requestFactory.makeLogoutRequestFactory()

        logout.logout(userId: 100) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Get catalog request

    private func getCatalog() {
        let getCatalog = requestFactory.makeCatalogRequestFactory()

        getCatalog.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Get product by id request

    private func getProduct() {
        let getProduct = requestFactory.makeProductRequestFactory()

        getProduct.getProduct(productId: 123) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Get product reviews page(s) by product id

    private func getReviews() {
        let getReviews = requestFactory.makeReviewsRequestFactory()

        getReviews.getReviews(productId: 456, pageNumber: 1) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Add product review

    private func addReview() {
        let addReview = requestFactory.makeReviewsRequestFactory()

        addReview.addReview(userId: 123, productId: 456, description: "Текст отзыва") { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }

        addReview.addReview(userId: nil, productId: 456, description: "Текст отзыва") { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Approve product review

    private func approveReview() {
        let approveReview = requestFactory.makeReviewsRequestFactory()

        approveReview.approveReview(userId: 123, reviewId: 112) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Remove product review

    private func removeReview() {
        let removeReview = requestFactory.makeReviewsRequestFactory()

        removeReview.removeReview(userId: 123, reviewId: 112) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Add product to basket

    private func addProductToBasket() {
        let basketFactory = requestFactory.makeBasketRequestFactory()

        basketFactory.addProduct(productId: 123, quantity: 1) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Remove product from basket

    private func removeProductFromBasket() {
        let basketFactory = requestFactory.makeBasketRequestFactory()

        basketFactory.removeProduct(productId: 123) { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    // MARK: - Pay basket

    private func payBasket() {
        let basketFactory = requestFactory.makeBasketRequestFactory()

        basketFactory.payBasket { response in
            switch response.result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(String(describing: error))
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

