//
//  SignInTextField.swift
//  GBShop
//
//  Created by Artem Mayer on 09.03.2023.
//

import UIKit

final class SignInTextField: UITextField {

    // MARK: - Private properties

    private let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(isSecureLabel: Bool) {
        super.init(frame: .zero)
        configure(isSecureLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // MARK: - Private functions

    private func configure(_ isSecureLabel: Bool = false) {
        font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        borderStyle = .none
        backgroundColor = .white
        clearButtonMode = .whileEditing
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        textColor = .label
        isSecureTextEntry = isSecureLabel
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        translatesAutoresizingMaskIntoConstraints = false
    }

}
