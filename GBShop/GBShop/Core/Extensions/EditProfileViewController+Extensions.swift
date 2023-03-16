//
//  EditProfileViewController+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

extension EditProfileViewController: UITextFieldDelegate {

    // MARK: - Functions

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            if nextField.alpha == 0 {
                return textFieldShouldReturn(nextField)
            }
            nextField.becomeFirstResponder()

        } else {
            performSaveAction()
        }

        return false
    }
}
