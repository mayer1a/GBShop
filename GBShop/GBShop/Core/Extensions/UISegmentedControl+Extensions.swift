//
//  UISegmentedControl+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 16.03.2023.
//

import UIKit

extension UISegmentedControl {

    // MARK: Functions

    func configure() {
        let font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        backgroundColor = .systemBackground
        tintColor = .label
        selectedSegmentTintColor = .systemGray5
    }
}
