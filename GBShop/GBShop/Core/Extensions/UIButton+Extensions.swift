//
//  UIButton+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

extension UIButton {

    // MARK: - Functions

    func configure(_ title: String?, titleColor: UIColor, backgroundColor: UIColor) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        setTitleColor(titleColor, for: .normal)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10.0
        clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}
