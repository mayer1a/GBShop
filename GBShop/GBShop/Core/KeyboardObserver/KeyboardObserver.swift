//
//  KeyboardObserver.swift
//  GBShop
//
//  Created by Artem Mayer on 10.03.2023.
//

import UIKit

/// Monitors the state of the keyboard and handles state change notifications
///
/// - Note: When the keyboard is displayed, the content view is shifted inside the scroll view (here it's the ``KeyboardObserver/targetView``).
///         When the keyboard is hidden, the offset is reset to zero
final class KeyboardObserver {

    // MARK: - Private properties

    private let targetView: UIScrollView?
    private let viewTag: Int?
    private var keyboardWillShowHandler: ((_ notification: NSNotification) -> Void)?
    private var keyboardWillHideHandler: ((_ notification: NSNotification) -> Void)?

    // MARK: - Constructions


    /// Main initializer with required and optional properties, to be used on the authorization screen to offset the view defined by the second tag parameter
    /// - Parameters:
    ///   - targetView: The view to which the offset changes will be applied
    ///   - viewTag: The view tag to which the screen will be shifted. Default is `nil`
    ///
    /// - Note: When used in the ``SignInView``, the tag of the bottom element of the screen must be passed to the second parameter
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

    @objc private func keyboardWillHide(notification: NSNotification) {
        targetView?.contentInset = .zero
        keyboardWillHideHandler?(notification)
    }
}
