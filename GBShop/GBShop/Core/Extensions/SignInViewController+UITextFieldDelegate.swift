//
//  SignInViewController+UITextFieldDelegate.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

extension SignInViewController: UITextFieldDelegate {

    // MARK: - Functions

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            performSignIn()
        }

        return false
    }
}
