//
//  RemoveReviewResult.swift
//  GBShop
//
//  Created by Artem Mayer on 27.02.2023.
//

import Foundation

/// The data model of the server's response to a request to remove a specific review.
struct RemoveReviewResult: Codable {

    // MARK: - Properties

    let result: Int
}
