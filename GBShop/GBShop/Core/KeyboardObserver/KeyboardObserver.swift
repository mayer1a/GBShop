//
//  KeyboardObserver.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

final class KeyboardObserver {

    // MARK: - Properties

    let targetView: UIScrollView?
    var keyboardWillShowHandler: ((_ notification: NSNotification) -> Void)?
    var keyboardWillHideHandler: ((_ notification: NSNotification) -> Void)?

    // MARK: - Private properties

    let viewTag: Int?

    // MARK: - Constructions

    init(targetView: UIScrollView?, scrollTo viewTag: Int? = nil) {
        self.targetView = targetView
        self.viewTag = viewTag

        createNotifications()
    }

    deinit {
        removeNotifications()
    }

    // MARK: - Private functions

    private func createNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, 
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo as? NSDictionary
        let keyboardSize = info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue

        guard
            let keyboardSize = keyboardSize?.cgRectValue.size,
            var viewRectangle = targetView?.superview?.safeAreaLayoutGuide.layoutFrame
        else {
            return
        }

        targetView?.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

        let additionalInset = LayoutConstants.keyboardAdditionalIndent
        let safeAreaInset = viewRectangle.origin.y
        viewRectangle.size.height -= keyboardSize.height + additionalInset + safeAreaInset

        let signUpFrame = getFrameToScroll()

        guard !viewRectangle.contains(signUpFrame) else { return }

        let rectangleWithIndent = CGRect(
            x: signUpFrame.origin.x,
            y: signUpFrame.origin.y,
            width: viewRectangle.width,
            height: signUpFrame.height + additionalInset)

        targetView?.scrollRectToVisible(rectangleWithIndent, animated: true)
    }

    private func getFrameToScroll() -> CGRect {
        var frame: CGRect?
        let subviews = targetView?.subviews.first?.subviews

        if let viewTag {
            frame = (targetView?.viewWithTag(viewTag) as? UIButton)?.frame
        } else {
            frame = subviews?.first(where: { ($0 as? UITextField)?.isFirstResponder == true })?.frame
        }

        return frame ?? .zero
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        targetView?.contentInset = .zero
        keyboardWillHideHandler?(notification)
    }
}
