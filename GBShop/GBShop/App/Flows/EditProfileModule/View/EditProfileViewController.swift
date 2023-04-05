//
//  EditProfileViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {

    // MARK: - Private properties

    private var presenter: EditProfilePresenterProtocol!
    private var keyboardObserver: KeyboardObserver?

    private var profileView: ProfileView? {
        isViewLoaded ? view as? ProfileView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ProfileView(actionButtonTitle: "Cохранить", isRepeatPasswordHidden: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        keyboardObserver = KeyboardObserver(targetView: profileView?.scrollView)

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            setupUITests()
        }
        #endif
    }

    // MARK: - Functions

    func setPresenter(_ presenter: EditProfilePresenterProtocol) {
        self.presenter = presenter
    }

    func performSaveAction() {
        saveButtonTapped()
    }

    // MARK: - Private functions

    private func setupViewComponents() {
        addTargets()
        completeFields()

        setupTextFieldsDelegate(profileView?.nameTextField)
        setupTextFieldsDelegate(profileView?.lastnameTextField)
        setupTextFieldsDelegate(profileView?.usernameTextField)
        setupTextFieldsDelegate(profileView?.emailTextField)
        setupTextFieldsDelegate(profileView?.passwordTextField)
        setupTextFieldsDelegate(profileView?.repeatPasswordTextField)
        setupTextFieldsDelegate(profileView?.cardNumberTextField)
        setupTextFieldsDelegate(profileView?.bioTextField)

        setupExitButton()
    }

    private func addTargets() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardShouldBeHidden))
        profileView?.addGestureRecognizer(tapGestureRecognizer)
        profileView?.genderControl.addTarget(self, action: #selector(textFieldsEditingChanged), for: .valueChanged)
        profileView?.actionButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        profileView?.passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged), for: .editingChanged)
    }

    private func completeFields() {
        guard let profileView else { return }

        let indexShouldSelected = (0..<profileView.genderControl.numberOfSegments).first { index in
            profileView.genderControl.titleForSegment(at: index) == presenter.user.gender.rawValue
        }

        guard let indexShouldSelected else { return }

        profileView.genderControl.selectedSegmentIndex = indexShouldSelected
        profileView.nameTextField.text = presenter.user.name
        profileView.lastnameTextField.text = presenter.user.lastname
        profileView.usernameTextField.text = presenter.user.username
        profileView.emailTextField.text = presenter.user.email
        profileView.cardNumberTextField.text = presenter.user.creditCard
        profileView.bioTextField.text = presenter.user.bio
    }

    private func setupTextFieldsDelegate(_ textField: UITextField?) {
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldsEditingChanged), for: .editingChanged)
    }

    private func setupExitButton() {
        let exitButton = UIBarButtonItem(title: "ВЫЙТИ", style: .plain, target: self, action: #selector(exitButtonDidTap))
        navigationItem.rightBarButtonItem = exitButton
    }

    private func getRawModelFromInput() -> SignUpRawModel {
        guard let profileView else { return SignUpRawModel() }

        let index = profileView.genderControl.selectedSegmentIndex
        let gender = profileView.genderControl.titleForSegment(at: index)

        return SignUpRawModel(
            name: profileView.nameTextField.text,
            lastname: profileView.lastnameTextField.text,
            username: profileView.usernameTextField.text,
            password: profileView.passwordTextField.text,
            repeatPassword: profileView.repeatPasswordTextField.text,
            email: profileView.emailTextField.text,
            creditCard: profileView.cardNumberTextField.text,
            gender: gender,
            bio: profileView.bioTextField.text)
    }

    private func shouldShowRepeatPassword(_ isHidden: Bool) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: isHidden ? 0.5 : 0, relativeDuration: 0.5) {
                self.profileView?.repeatPasswordTextField.alpha = isHidden ? 0 : 0.5
                self.profileView?.repeatPasswordConstraints.forEach({ $0.isActive = !isHidden })
                self.profileView?.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: isHidden ? 0 : 0.5, relativeDuration: 0.5) {
                self.profileView?.repeatPasswordTextField.alpha = isHidden ? 0.5 : 1
            }
        } completion: { _ in
            self.profileView?.repeatPasswordTextField.alpha = isHidden ? 0 : 1
        }
    }

    @objc private func saveButtonTapped() {
        presenter?.editButtonTapped(rawModel: getRawModelFromInput())
    }

    @objc private func textFieldsEditingChanged(_ sender: UITextField) {
        presenter?.inputFieldsTapped()
    }

    @objc private func keyboardShouldBeHidden() {
        profileView?.scrollView.endEditing(true)
    }

    @objc private func passwordTextFieldEditingChanged(_ sender: UITextField) {
        guard let isEmpty = sender.text?.isEmpty, let repeatButton = profileView?.repeatPasswordTextField else { return }
        if (!isEmpty && repeatButton.alpha == 0) || (isEmpty && repeatButton.alpha == 1) {
            shouldShowRepeatPassword(isEmpty)
        }
    }

    @objc private func exitButtonDidTap(_ sender: UIButton) {
        presenter.exitButtonDidTap()
    }

    private func setupUITests() {
        view.accessibilityIdentifier = "profileView"
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "logoutButton"
    }
}

// MARK: - Extensions

extension EditProfileViewController: EditProfileViewProtocol {

    // MARK: - Functions
    
    func startLoadingSpinner() {
        keyboardShouldBeHidden()
        profileView?.loadingSpinner.startAnimating()
        profileView?.actionButton.setTitle("", for: .normal)
    }

    func stopLoadingSpinner() {
        profileView?.loadingSpinner.stopAnimating()
        profileView?.actionButton.setTitle("Сохранить", for: .normal)
    }

    func editFailure(with message: String?) {
        profileView?.warningLabel.text = message

        UIView.animate(withDuration: 0.3) {
            self.profileView?.warningLabel.alpha = 1
            self.profileView?.layoutIfNeeded()
        }
    }

    func removeWarning() {
        UIView.animate(withDuration: 0.3) {
            self.profileView?.warningLabel.alpha = 0
            self.profileView?.layoutIfNeeded()
        } completion: { _ in
            self.profileView?.warningLabel.text = ""
        }
    }
}
