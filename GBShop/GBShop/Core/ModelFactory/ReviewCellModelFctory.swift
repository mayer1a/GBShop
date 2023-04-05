//
//  ReviewCellModelFctory.swift
//  GBShop
//
//  Created by Artem Mayer on 28.03.2023.
//

import Foundation

struct ReviewCellModelFactory {

    // MARK: - Private properties

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        return formatter
    }()

    // MARK: - Functions

    static func construct(from reviews: [Review]) -> [ReviewCellModel] {
        reviews.compactMap { review -> ReviewCellModel in construct(from: review) }
    }

    static func construct(from review: Review) -> ReviewCellModel {
        ReviewCellModel(
            userId: "\(review.id)",
            body: review.body,
            reviewStars: review.rating,
            date: convertDate(from: review.date))
    }

    // MARK: - Private functions

    private static func convertDate(from date: TimeInterval) -> String {
        let currentTime = Date().timeIntervalSince1970

        let hasHalfYearPassed = currentTime - date > TimeConstants.halfYear
        dateFormatter.dateFormat = hasHalfYearPassed ? "d MMMM yyyy" : "d MMMM"

        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }
}
