//
//  EditProfileViewController+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

extension EditProfileViewController: UITextFieldDelegate {

    // MARK: - Functions

    /// Method of transition to the next `textField` based on the tagging of elements when pressing the **return** button on the keyboard.
    ///
    /// - Note: If it is the last text field, data saving will be initiated.
    ///         If the next field is hidden, ``textFieldShouldReturn(_:)`` this function will be recursively called again.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            if nextField.alpha.isZero {
                return textFieldShouldReturn(nextField)
            }
            nextField.becomeFirstResponder()

        } else {
            performSaveAction()
        }

        return false
    }
}
