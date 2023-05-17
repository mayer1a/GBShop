//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

/// The main contract for the error parser with two main methods
/// ``parse(_:)`` and ``parse(response:data:error:)``
protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
