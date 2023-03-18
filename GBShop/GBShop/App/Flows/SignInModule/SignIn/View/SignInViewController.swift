//
//  SignInViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 07.03.2023.
//

import UIKit

final class SignInViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: SignInPresenterProtocol!
    private var keyboardObserver: KeyboardObserver?
    private let signUpButtonTag = 10

    private var signInView: SignInView? {
        isViewLoaded ? view as? SignInView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = SignInView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTargets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: SignInPresenterProtocol) {
        self.presenter = presenter
    }

    func performSignIn() {
        signInButtonTapped()
    }

    // MARK: - Private functions

    private func setupViewTargets() {
        keyboardObserver = KeyboardObserver(targetView: signInView?.scrollView, scrollTo: signUpButtonTag)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardShouldBeHidden))
        signInView?.addGestureRecognizer(tapGestureRecognizer)
        signInView?.signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInView?.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInView?.signUpButton.tag = signUpButtonTag

        setupTextFieldsDelegate(signInView?.emailTextField)
        setupTextFieldsDelegate(signInView?.passwordTextField)
    }

    private func setupTextFieldsDelegate(_ textField: UITextField?) {
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(inputTextFieldsBeginEditing), for: .editingChanged)
    }

    private func configureNavigationController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc private func signInButtonTapped() {
        presenter.signIn(email: signInView?.emailTextField.text, password: signInView?.passwordTextField.text)
    }

    @objc private func signUpButtonTapped() {
        presenter.signUpButtonTapped()
    }

    @objc private func inputTextFieldsBeginEditing(_ sender: UITextField) {
        presenter.inputFieldsTapped()
    }

    @objc private func keyboardShouldBeHidden() {
        signInView?.scrollView.endEditing(true)
    }

}

extension SignInViewController: SignInViewProtocol {

    // MARK: - Functions

    func startLoadingSpinner() {
        keyboardShouldBeHidden()
        signInView?.loadingSpinner.startAnimating()
        signInView?.signInButton.setTitle("", for: .normal)
    }

    func stopLoadingSpinner() {
        signInView?.loadingSpinner.stopAnimating()
        signInView?.signInButton.setTitle("Войти", for: .normal)
    }

    func signInFailure(with errorMessage: String?) {
        signInView?.warningLabel.text = errorMessage
        
        UIView.animate(withDuration: AnimationConstants.animationDuration) { [weak self] in
            self?.signInView?.warningLabel.alpha = 1
            self?.signInView?.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            self?.signInView?.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }

    func removeWarning() {
        UIView.animate(withDuration: AnimationConstants.animationDuration) { [weak self] in
            self?.signInView?.warningLabel.alpha = 0
            self?.signInView?.emailTextField.layer.borderColor = UIColor.systemGray5.cgColor
            self?.signInView?.passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        } completion: { _ in
            self.signInView?.warningLabel.text = ""
        }
    }
}
