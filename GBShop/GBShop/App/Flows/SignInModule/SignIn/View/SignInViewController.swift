//
//  SignInViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 07.03.2023.
//

import UIKit

final class SignInViewController: UIViewController {

    // MARK: - Properties

    var presenter: SignInPresenterProtocol?
    var keyboardObserver: KeyboardObserver?

    // MARK: - Private properties

    private let scrollView: UIScrollView
    private let contentView: UIView
    private let loginTextField: SignInTextField
    private let passwordTextField: SignInTextField
    private let signInButton: UIButton
    private let signUpButton: UIButton
    private let headerLabel: UILabel
    private let warningLabel: WarningPaddingLabel
    private lazy var loadingSpinner = UIActivityIndicatorView(style: .large)

    // MARK: - Constructions

    required init() {
        scrollView = UIScrollView()
        contentView = UIView()
        loginTextField = SignInTextField()
        passwordTextField = SignInTextField()
        signInButton = UIButton(type: .roundedRect)
        signUpButton = UIButton(type: .roundedRect)
        headerLabel = UILabel()
        warningLabel = WarningPaddingLabel()

        super.init(nibName: nil, bundle: nil)
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardObserver = KeyboardObserver(targetView: scrollView, isSignInFlow: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Functions

    func performSignIn() {
        signInButtonTapped()
    }

    @objc func keyboardShouldBeHidden() {
        scrollView.endEditing(true)
    }

    // MARK: - Private functions

    private func configureViewComponents() {
        view.backgroundColor = .systemBackground
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardShouldBeHidden))
        view.addGestureRecognizer(tapGestureRecognizer)

        configureScrollView()
        configureContentView()
        configureHeaderLabel()
        configureWarningLabel()
        configureLoginTextField()
        configurePasswordTextField()
        configureSignInButton()
        configureSignUpButton()
        configureSpinner()
    }

    private func configureScrollView() {
        view.addSubview(scrollView)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerLabel)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        contentView.addSubview(warningLabel)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func configureHeaderLabel() {
        let headerText = "войти или зарегистрироваться"
        headerLabel.textColor = .label
        configureLabel(headerLabel, text: headerText, font: .systemFont(ofSize: 33.0, weight: .bold))

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -20),
            headerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            headerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }

    private func configureWarningLabel() {
        let warningText = """
        Похоже, вы вводите неправильный email или пароль. Попробуйте еще раз
        """
        warningLabel.textColor = .systemRed
        warningLabel.isHidden = true
        configureLabel(warningLabel, text: warningText, font: .systemFont(ofSize: 16))

        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            warningLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            warningLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            warningLabel.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -10)
        ])
    }

    private func configureLoginTextField() {
        loginTextField.placeholder = "E-mail"
        loginTextField.keyboardType = .emailAddress
        loginTextField.textContentType = .emailAddress
        loginTextField.returnKeyType = .next
        loginTextField.tag = 2
        configureTextField(loginTextField)

        NSLayoutConstraint.activate([
            loginTextField.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30),
            loginTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            loginTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configurePasswordTextField() {
        passwordTextField.textContentType = .password
        passwordTextField.returnKeyType = .continue
        passwordTextField.tag = loginTextField.tag + 1
        passwordTextField.configure(placeholder: "Пароль", isSecureTextEntry: true)
        configureTextField(passwordTextField)

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor)
        ])
    }

    private func configureSignInButton() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInButton.tag = 12
        configureButton(signInButton, with: "Войти", color: .label, titleColor: .systemBackground)

        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            signInButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalTo: signUpButton.heightAnchor)
        ])
    }

    private func configureSignUpButton() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.tag = signInButton.tag + 1
        configureButton(signUpButton, with: "Зарегистрироваться", color: .systemBackground, titleColor: .label)

        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            signUpButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            signUpButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalTo: loginTextField.heightAnchor)
        ])
    }

    private func configureSpinner() {
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.color = .systemBackground

        signInButton.addSubview(loadingSpinner)

        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
        ])
    }

    private func configureTextField(_ textField: UITextField) {
        textField.delegate = self
        textField.addTarget(self, action: #selector(inputTextFieldsBeginEditing), for: .editingChanged)
    }

    private func configureButton(_ button: UIButton, with title: String, color: UIColor, titleColor: UIColor) {
        button.backgroundColor = color
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLabel(_ label: UILabel, text: String = "", font: UIFont = .systemFont(ofSize: 20)) {
        label.text = text
        label.font = font
        label.backgroundColor = .systemBackground
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
    }

    @objc private func signInButtonTapped() {
        presenter?.signIn(email: loginTextField.text, password: passwordTextField.text)
    }

    @objc private func signUpButtonTapped() {
        presenter?.signUpButtonTapped()
    }

    @objc private func inputTextFieldsBeginEditing(_ sender: UITextField) {
        presenter?.inputFieldsTapped()
    }

}

extension SignInViewController: SignInViewProtocol {

    // MARK: - Functions

    func startLoadingSpinner() {
        keyboardShouldBeHidden()
        loadingSpinner.startAnimating()
        signInButton.setTitle("", for: .normal)
    }

    func stopLoadingSpinner() {
        loadingSpinner.stopAnimating()
        signInButton.setTitle("Войти", for: .normal)
    }

    func signInFailure() {
        warningLabel.isHidden = false
        loginTextField.layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
    }

    func removeWarning() {
        warningLabel.isHidden = true
        loginTextField.layer.borderColor = UIColor.systemGray5.cgColor
        passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
