//
//  SignUpViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 14.03.2023.
//

import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: SignUpPresenterProtocol!
    private var keyboardObserver: KeyboardObserver?

    private var profileView: ProfileView? {
        isViewLoaded ? view as? ProfileView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ProfileView(actionButtonTitle: "Зарегистрироваться")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTargets()
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            setupUITests()
        }
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }

    // MARK: - Functions

    func setPresenter(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }

    func performSignUp() {
        signUpButtonTapped()
    }

    // MARK: - Private functions

    private func setupViewTargets() {
        keyboardObserver = KeyboardObserver(targetView: profileView?.scrollView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardShouldBeHidden))
        profileView?.addGestureRecognizer(tapGestureRecognizer)
        profileView?.genderControl.addTarget(self, action: #selector(textFieldsEditingChanged), for: .valueChanged)
        profileView?.actionButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        setupTextFieldsDelegate(profileView?.nameTextField)
        setupTextFieldsDelegate(profileView?.lastnameTextField)
        setupTextFieldsDelegate(profileView?.usernameTextField)
        setupTextFieldsDelegate(profileView?.emailTextField)
        setupTextFieldsDelegate(profileView?.passwordTextField)
        setupTextFieldsDelegate(profileView?.repeatPasswordTextField)
        setupTextFieldsDelegate(profileView?.cardNumberTextField)
        setupTextFieldsDelegate(profileView?.bioTextField)
    }

    private func setupTextFieldsDelegate(_ textField: UITextField?) {
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldsEditingChanged), for: .editingChanged)
    }

    private func configureNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Регистрация"
        navigationController?.navigationBar.backItem?.backButtonTitle = "Назад"
    }

    private func getRawModelFromInput() -> SignUpRawModel {
        guard let profileView else { return SignUpRawModel() }

        let index = profileView.genderControl.selectedSegmentIndex
        let gender = index != -1 ? profileView.genderControl.titleForSegment(at: index) : nil

        return SignUpRawModel(
            name: profileView.nameTextField.text,
            lastname: profileView.lastnameTextField.text,
            username: profileView.usernameTextField.text,
            password: profileView.passwordTextField.text,
            repeatPassword: profileView.repeatPasswordTextField.text ?? "",
            email: profileView.emailTextField.text,
            creditCard: profileView.cardNumberTextField.text,
            gender: gender,
            bio: profileView.bioTextField.text)
    }

    @objc private func signUpButtonTapped() {
        profileView?.bioTextField.becomeFirstResponder()
        profileView?.bioTextField.resignFirstResponder()
        presenter.signUpButtonTapped(rawModel: getRawModelFromInput())
    }

    @objc private func textFieldsEditingChanged(_ sender: UITextField) {
        presenter.inputFieldsTapped()
    }

    @objc private func keyboardShouldBeHidden() {
        profileView?.scrollView.endEditing(true)
    }

    private func setupUITests() {
        view.accessibilityIdentifier =  "signUpView"
        profileView?.nameTextField.accessibilityIdentifier = "nameTextField"
        profileView?.lastnameTextField.accessibilityIdentifier = "lastnameTextField"
        profileView?.usernameTextField.accessibilityIdentifier = "usernameTextField"
        profileView?.emailTextField.accessibilityIdentifier = "emailTextField"
        profileView?.passwordTextField.accessibilityIdentifier = "passwordTextField"
        profileView?.repeatPasswordTextField.accessibilityIdentifier = "repeatPasswordTextField"
        profileView?.cardNumberTextField.accessibilityIdentifier = "cardNumberTextField"
        profileView?.genderControl.accessibilityIdentifier = "genderControl"
        profileView?.bioTextField.accessibilityIdentifier = "bioTextField"
        profileView?.actionButton.accessibilityIdentifier = "signUpButtonSignUpView"
        profileView?.warningLabel.accessibilityIdentifier = "warningLabel"
    }
}

// MARK: - Extensions

extension SignUpViewController: SignUpViewProtocol {

    // MARK: - Functions

    func startLoadingSpinner() {
        keyboardShouldBeHidden()
        profileView?.loadingSpinner.startAnimating()
        profileView?.actionButton.setTitle("", for: .normal)
    }

    func stopLoadingSpinner() {
        profileView?.loadingSpinner.stopAnimating()
        profileView?.actionButton.setTitle("Зарегистрироваться", for: .normal)
    }

    func signUpFailure(with message: String?) {
        profileView?.warningLabel.text = message

        UIView.animate(withDuration: AnimationConstants.animationDuration) { [weak self] in
            self?.profileView?.warningLabel.alpha = 1.0
            self?.profileView?.layoutIfNeeded()
        }
    }

    func removeWarning() {
        UIView.animate(withDuration: AnimationConstants.animationDuration) { [weak self] in
            self?.profileView?.warningLabel.alpha = .zero
            self?.profileView?.layoutIfNeeded()
        } completion: { _ in
            self.profileView?.warningLabel.text = ""
        }
    }

}
