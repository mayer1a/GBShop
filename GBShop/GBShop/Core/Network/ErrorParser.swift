//
//  ErrorParser.swift
//  GBShop
//
//  Created by Artem Mayer on 13.02.2023.
//

import Foundation

// MARK: - AbstractErrorParser

/// Parsing error handler
final class ErrorParser: AbstractErrorParser {

    // MARK: - Functions
    
    func parse(_ result: Error) -> Error {
        result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        error
    }
}
