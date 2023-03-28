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

    static func construct(from review: Review) -> ReviewCellModel {
        ReviewCellModel(
            userId: "\(review.id)",
            body: review.body,
            reviewStars: review.rating,
            date: convertDate(from: review.date))
    }

    private static func convertDate(from date: TimeInterval) -> String {
        let currentTime = Date().timeIntervalSince1970

        if currentTime - date > 182 {
            dateFormatter.dateFormat = "d LLLL yyyy"
        } else {
            dateFormatter.dateFormat = "d LLLL"
        }

        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }
}
