//
//  ProfileView.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

final class ProfileView: UIView {

    // MARK: - Properties

    let scrollView = UIScrollView()
    let nameTextField = ProfileTextField()
    let lastnameTextField = ProfileTextField()
    let usernameTextField = ProfileTextField()
    let emailTextField = ProfileTextField()
    let passwordTextField = ProfileTextField()
    let repeatPasswordTextField = ProfileTextField()
    let cardNumberTextField = ProfileTextField()
    let genderControl: UISegmentedControl
    let bioTextField = ProfileTextField()
    let actionButton = UIButton(type: .roundedRect)
    let warningLabel = WarningPaddingLabel()
    let loadingSpinner = UIActivityIndicatorView(style: .large)
    var repeatPasswordConstraints: [NSLayoutConstraint] = []

    // MARK: - Private properties
    
    private let contentView = UIView()
    private let genderItems: [String]
    private let actionButtonTitle: String
    private let isRepeatPasswordHidden: Bool
    private var textFieldTag = 0
    private var nextTag: Int {
        get {
            textFieldTag += 1
            return textFieldTag
        }
    }

    // MARK: - Constructions

    required init(actionButtonTitle: String, isRepeatPasswordHidden: Bool = false) {
        genderItems = [Gender.man.rawValue, Gender.woman.rawValue, Gender.indeterminate.rawValue]
        genderControl = UISegmentedControl(items: genderItems)
        self.actionButtonTitle = actionButtonTitle
        self.isRepeatPasswordHidden = isRepeatPasswordHidden

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
        configureWarningLabel()
        configureNameTextField()
        configureLastnameTextField()
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureRepeatPasswordTextField()
        configureGenderControl()
        configureCardNumberTextField()
        configureBioTextField()
        configureActionButton()
        configureSpinner()
    }

    private func configureScrollView() {
        scrollView.addSubview(contentView)
        scrollView.keyboardDismissMode = .interactive
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func configureContentView() {
        contentView.addSubview(warningLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(lastnameTextField)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(repeatPasswordTextField)
        contentView.addSubview(genderControl)
        contentView.addSubview(cardNumberTextField)
        contentView.addSubview(bioTextField)
        contentView.addSubview(actionButton)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func configureWarningLabel() {
        warningLabel.alpha = 0
        warningLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            warningLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            warningLabel.rightAnchor.constraint(equalTo: nameTextField.rightAnchor)
        ])
    }

    private func configureNameTextField() {
        nameTextField.textContentType = .givenName
        nameTextField.returnKeyType = .next
        configureTextField(nameTextField, placeholder: "Имя")

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 20),
            nameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureLastnameTextField() {
        lastnameTextField.textContentType = .familyName
        lastnameTextField.returnKeyType = .next
        lastnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true

        configureTextField(lastnameTextField, placeholder: "Фамилия")
        setupBaseConstraints(from: lastnameTextField, to: nameTextField)
    }

    private func configureUsernameTextField() {
        usernameTextField.textContentType = .nickname
        usernameTextField.returnKeyType = .next
        usernameTextField.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 10).isActive = true

        configureTextField(usernameTextField, placeholder: "Логин")
        setupBaseConstraints(from: usernameTextField, to: nameTextField)
    }

    private func configureEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true

        configureTextField(emailTextField, placeholder: "Почта")
        setupBaseConstraints(from: emailTextField, to: nameTextField)
    }

    private func configurePasswordTextField() {
        passwordTextField.textContentType = .fullStreetAddress
        passwordTextField.returnKeyType = .next
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true

        configureTextField(passwordTextField, placeholder: "Пароль", isSecure: true)
        setupBaseConstraints(from: passwordTextField, to: nameTextField)
    }

    private func configureRepeatPasswordTextField() {
        repeatPasswordTextField.alpha = isRepeatPasswordHidden ? 0 : 1
        repeatPasswordTextField.textContentType = .fullStreetAddress
        repeatPasswordTextField.returnKeyType = .next
        repeatPasswordConstraints = [
            repeatPasswordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10)
        ]
        repeatPasswordConstraints.forEach({ $0.isActive = !isRepeatPasswordHidden })

        configureTextField(repeatPasswordTextField, placeholder: "Повторите пароль", isSecure: true)

        NSLayoutConstraint.activate([
            repeatPasswordTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            repeatPasswordTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor)
        ])
    }

    private func configureGenderControl() {
        genderControl.configure()
        genderControl.translatesAutoresizingMaskIntoConstraints = false
        genderControl.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10).isActive = true
        genderControl.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: 10).isActive = true

        setupBaseConstraints(from: genderControl, to: nameTextField)
    }

    private func configureCardNumberTextField() {
        cardNumberTextField.keyboardType = .numberPad
        cardNumberTextField.textContentType = .telephoneNumber
        cardNumberTextField.returnKeyType = .next
        cardNumberTextField.topAnchor.constraint(equalTo: genderControl.bottomAnchor, constant: 10).isActive = true

        configureTextField(cardNumberTextField, placeholder: "Номер платёжной карты")
        setupBaseConstraints(from: cardNumberTextField, to: nameTextField)
    }

    private func configureBioTextField() {
        bioTextField.returnKeyType = .continue
        bioTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 10).isActive = true

        configureTextField(bioTextField, placeholder: "О себе")
        setupBaseConstraints(from: bioTextField, to: nameTextField)
    }

    private func configureActionButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 20).isActive = true
        actionButton.addSubview(loadingSpinner)
        actionButton.configure(actionButtonTitle, titleColor: .systemBackground, backgroundColor: .label)

        setupBaseConstraints(from: actionButton, to: nameTextField)
    }

    private func configureSpinner() {
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.color = .systemBackground

        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor)
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

    private func didT(_ sender: UITextField) {
        guard let isHidden = sender.text?.isEmpty else { return }

        repeatPasswordTextField.isHidden = isHidden
        repeatPasswordConstraints.forEach({ $0.isActive = !isHidden })
    }
}
