//
//  SignInViewController+UITextFieldDelegate.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

extension SignInViewController: UITextFieldDelegate {

    // MARK: - Functions

    /// Method of transition to the next `textField` based on the tagging of elements when pressing the **return** button on the keyboard.
    ///
    /// - Note: If this is the last text field, authorization will be initiated.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            performSignIn()
        }

        return false
    }
}
