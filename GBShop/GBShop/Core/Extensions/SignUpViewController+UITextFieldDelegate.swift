//
//  SignUpViewController+UITextFieldDelegate.swift
//  GBShop
//
//  Created by Artem Mayer on 14.03.2023.
//

import UIKit

extension SignUpViewController: UITextFieldDelegate {

    // MARK: - Functions

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            if nextField.alpha == 0 {
                return textFieldShouldReturn(nextField)
            }
            nextField.becomeFirstResponder()

        } else {
            performSignUp()
        }

        return false
    }
}
