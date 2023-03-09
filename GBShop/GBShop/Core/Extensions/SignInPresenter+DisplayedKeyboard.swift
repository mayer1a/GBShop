//
//  SignInPresenter+DisplayedKeyboard.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

protocol DisplayedKeyboard {
    func moveFrameUp(_ notification: Notification)
    func moveFrameBack()
}

extension SignInPresenter: DisplayedKeyboard {

    // MARK: - Functions
    
    @objc func moveFrameUp(_ notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let keyboardSize = info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue

        guard
            let keyboardSize = keyboardSize?.cgRectValue.size,
            let view
        else {
            return
        }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

        view.scrollView.contentInset = contentInsets

        var viewRectangle = view.getSafeAreaLayoutFrame()
        let additionalInset: CGFloat = 40
        let safeAreaInset: CGFloat = viewRectangle.origin.y
        viewRectangle.size.height -= keyboardSize.height + additionalInset + safeAreaInset

        let signUpFrame = view.getSignInButtonFrame()

        guard !viewRectangle.contains(signUpFrame.origin) else { return }

        let rectangleWithIndent = CGRect(
            x: signUpFrame.origin.x,
            y: signUpFrame.origin.y,
            width: viewRectangle.width,
            height: signUpFrame.height + additionalInset)

        view.scrollView.scrollRectToVisible(rectangleWithIndent, animated: true)
    }

    @objc func moveFrameBack() {
        view?.scrollView.contentInset = .zero
    }
}
