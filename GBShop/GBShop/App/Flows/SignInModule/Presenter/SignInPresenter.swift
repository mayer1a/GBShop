//
//  SignInPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 07.03.2023.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func startLoadingSpinner()
    func stopLoadingSpinner()
    func signInFailure()
    func removeWarning()
}

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewProtocol, requestFactory: SignInRequestFactory)

    func signIn(username: String, password: String)
    func signUpButtonTapped()
    func inputFieldsTapped()

    var user: SignInResult? { get }
}

final class SignInPresenter: SignInPresenterProtocol {

    // MARK: - Private properties

    weak var view: SignInViewProtocol?
    let requestFactory: SignInRequestFactory!
    var user: SignInResult?

    // MARK: - Constructions

    init(view: SignInViewProtocol, requestFactory: SignInRequestFactory) {
        self.view = view
        self.requestFactory = requestFactory
    }

    // MARK: - Functions

    func signIn(username: String, password: String) {
        view?.startLoadingSpinner()

        requestFactory?.login(userName: username, password: password) { [weak self] response in
            switch response.result {
            case .success(let user):
                self?.user = user
                // TODO: Go to Main screen through the Coordinator
            case .failure(_):
                self?.view?.signInFailure()
            }

            self?.view?.stopLoadingSpinner()
        }
    }

    func signUpButtonTapped() {
        // TODO: Go to SignUp screen through the Coordinator
    }

    func inputFieldsTapped() {
        view?.removeWarning()
    }

}
