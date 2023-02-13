//
//  UniqueID.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

/// Imitation of obtaining a unique identifier from the server
final class UniqueID {

    // MARK: - Private properties

    private static var counter: Int = .zero

    // MARK: - Functions

    /// Returns the unique identifier from the server
    /// - Returns: The integer value
    public static func getUniqueId() -> Int {
        counter += 1
        return counter
    }
}
