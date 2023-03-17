//
//  EditProfileViewController.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {

    // MARK: - Properties

    var presenter: EditProfilePresenterProtocol?
    var keyboardObserver: KeyboardObserver?

    // MARK: - Private properties

    private var profileView: ProfileView? {
        isViewLoaded ? view as? ProfileView : nil
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ProfileView(actionButtonTitle: "Cохранить", isRepeatPasswordHidden: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTargets()
        keyboardObserver = KeyboardObserver(targetView: profileView?.scrollView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }

    // MARK: - Functions

    func performSaveAction() {
        saveButtonTapped()
    }

    // MARK: - Private functions

    private func setupViewTargets() {
        guard let profileView else { return }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardShouldBeHidden))
        profileView.addGestureRecognizer(tapGestureRecognizer)
        profileView.genderControl.addTarget(self, action: #selector(textFieldsEditingChanged), for: .valueChanged)
        profileView.actionButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        profileView.nameTextField.text = presenter?.user.name
        profileView.lastnameTextField.text = presenter?.user.lastname
        profileView.usernameTextField.text = presenter?.user.username
        profileView.emailTextField.text = presenter?.user.email
        profileView.cardNumberTextField.text = presenter?.user.creditCard
        profileView.bioTextField.text = presenter?.user.bio
        
        let indexShouldSelected = (0..<profileView.genderControl.numberOfSegments).first { index in
            profileView.genderControl.titleForSegment(at: index) == presenter?.user.gender.rawValue
        }

        guard let indexShouldSelected else { return }

        profileView.genderControl.selectedSegmentIndex = indexShouldSelected

        setupTextFieldsDelegate(profileView.nameTextField)
        setupTextFieldsDelegate(profileView.lastnameTextField)
        setupTextFieldsDelegate(profileView.usernameTextField)
        setupTextFieldsDelegate(profileView.emailTextField)
        setupTextFieldsDelegate(profileView.passwordTextField)
        setupTextFieldsDelegate(profileView.repeatPasswordTextField)
        setupTextFieldsDelegate(profileView.cardNumberTextField)
        setupTextFieldsDelegate(profileView.bioTextField)

        profileView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingChanged), for: .editingChanged)
    }

    private func setupTextFieldsDelegate(_ textField: UITextField?) {
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldsEditingChanged), for: .editingChanged)
    }

    private func configureNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Профиль"
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
        guard let isEmpty = sender.text?.isEmpty, let repeatButton = profileView?.repeatPasswordTextField  else { return }
        if (!isEmpty && repeatButton.alpha == 0) || (isEmpty && repeatButton.alpha == 1) {
            shouldShowRepeatPassword(isEmpty)
        }
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
