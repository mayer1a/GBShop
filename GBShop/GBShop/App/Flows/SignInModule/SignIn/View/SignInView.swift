//
//  SignInView.swift
//  GBShop
//
//  Created by Artem Mayer on 17.03.2023.
//

import UIKit

final class SignInView: UIView {

    // MARK: - Properties

    let scrollView = UIScrollView()
    let emailTextField = ProfileTextField()
    let passwordTextField = ProfileTextField()
    let signInButton = UIButton(type: .roundedRect)
    let signUpButton = UIButton(type: .roundedRect)
    let headerLabel = UILabel()
    let warningLabel = WarningPaddingLabel()
    let loadingSpinner = UIActivityIndicatorView(style: .large)

    // MARK: - Private properties

    private let contentView = UIView()
    private var textFieldTag = 0
    private var nextTag: Int {
        get {
            textFieldTag += 1
            return textFieldTag
        }
    }

    // MARK: - Constructions

    required init() {
        super.init(frame: .zero)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
        
        configureScrollView()
        configureContentView()
        configureHeaderLabel()
        configureWarningLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureSignInButton()
        configureSignUpButton()
        configureSpinner()
    }

    private func configureScrollView() {
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func configureContentView() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        contentView.addSubview(warningLabel)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func configureHeaderLabel() {
        headerLabel.text = "войти или зарегистрироваться"
        headerLabel.font = .systemFont(ofSize: 33.0, weight: .bold)
        headerLabel.textColor = .label
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.backgroundColor = .systemBackground
        headerLabel.isUserInteractionEnabled = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -20),
            headerLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor)
        ])
    }

    private func configureWarningLabel() {
        warningLabel.alpha = 0
        warningLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            warningLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            warningLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor),
            warningLabel.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -10)
        ])
    }

    private func configureEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.returnKeyType = .next
        configureTextField(emailTextField, placeholder: "E-mail")

        NSLayoutConstraint.activate([
            emailTextField.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30),
            emailTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configurePasswordTextField() {
        passwordTextField.textContentType = .password
        passwordTextField.returnKeyType = .continue
        configureTextField(passwordTextField, placeholder: "Пароль", isSecure: true)

        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        setupBaseConstraints(from: passwordTextField, to: emailTextField)
    }

    private func configureSignInButton() {
        signInButton.addSubview(loadingSpinner)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configure("Войти", titleColor: .systemBackground, backgroundColor: .label)

        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        setupBaseConstraints(from: signInButton, to: emailTextField)
    }

    private func configureSignUpButton() {
        signUpButton.configure("Зарегистрироваться", titleColor: .label, backgroundColor: .systemBackground)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10).isActive = true
        setupBaseConstraints(from: signUpButton, to: emailTextField)
    }

    private func configureSpinner() {
        loadingSpinner.color = .systemBackground
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
        ])
    }

    private func configureTextField(_ textField: ProfileTextField, placeholder: String, isSecure: Bool = false) {
        textField.tag = nextTag
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: placeholder, isSecureTextEntry: isSecure)
    }

    private func setupBaseConstraints(from: UIView, to: UIView) {
        NSLayoutConstraint.activate([
            from.leftAnchor.constraint(equalTo: to.leftAnchor),
            from.rightAnchor.constraint(equalTo: to.rightAnchor),
            from.heightAnchor.constraint(equalTo: to.heightAnchor)
        ])
    }
}
