//
//  Gender.swift
//  GBShop
//
//  Created by Artem Mayer on 01.03.2023.
//

import Foundation

/// Enumeration model for gender with a raw value representation.
enum Gender: String, Codable {
    case man = "Мужской"
    case woman = "Женский"
    case indeterminate = "Другой"
}
