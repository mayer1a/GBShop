//
//  UITabBarController+Extensions.swift
//  GBShop
//
//  Created by Artem Mayer on 23.03.2023.
//

import UIKit

extension UITabBarController {

    // MARK: - Functions

    /// Basic ``UITabBarController`` configuration method. Sets a white background, compact inline appearance for all states and removes translucent
    func configure() {
        let appearance = UITabBarAppearance(idiom: .phone)
        appearance.backgroundColor = .white
        appearance.stackedItemPositioning = .fill

        let itemAppearance = UITabBarItemAppearance(style: .compactInline)
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.standardAppearance = appearance
        self.tabBar.isTranslucent = false
    }
}
