//
//  SignInPresenter.swift
//  GBShop
//
//  Created by Artem Mayer on 07.03.2023.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    var scrollView: UIScrollView { get }

    func startLoadingSpinner()
    func stopLoadingSpinner()
    func signInFailure()
    func removeWarning()
    func getSignInButtonFrame() -> CGRect
    func getSafeAreaLayoutFrame() -> CGRect
    func signInSuccess(with userProfile: User)
}

protocol SignInPresenterProtocol: AnyObject {
    init(view: SignInViewProtocol, requestFactory: SignInRequestFactory)

    var user: User? { get }

    func signIn(username: String?, password: String?)
    func signUpButtonTapped()
    func inputFieldsTapped()
}

final class SignInPresenter {

    // MARK: - Properties

    weak var view: SignInViewProtocol?
    let requestFactory: SignInRequestFactory!
    var user: User?

    // MARK: - Constructions

    init(view: SignInViewProtocol, requestFactory: SignInRequestFactory) {
        self.view = view
        self.requestFactory = requestFactory

        addKeyboardObservers()
    }

    deinit {
        removeKeyboardObservers()
    }

    // MARK: - Private functions

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveFrameUp),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveFrameBack),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

}

extension SignInPresenter: SignInPresenterProtocol {

    // MARK: - Functions

    func signIn(username: String?, password: String?) {
        guard
            let username,
            let password
        else {
            view?.signInFailure()
            return
        }

        view?.startLoadingSpinner()

        requestFactory?.login(userName: username, password: password) { [weak self] response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let signInResult):
                    // TODO: Go to Main screen through the Coordinator
                    guard
                        let user = signInResult.user
                    else {
                        self?.view?.signInFailure()
                        break
                    }
                    
                    self?.view?.signInSuccess(with: user)
                case .failure(_):
                    self?.view?.signInFailure()
                }

                self?.view?.stopLoadingSpinner()
            }
        }
    }

    func signUpButtonTapped() {
        // TODO: Go to SignUp screen through the Coordinator
    }

    func inputFieldsTapped() {
        view?.removeWarning()
    }
}
