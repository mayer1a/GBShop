//
//  AnalyticsEvent.swift
//  GBShop
//
//  Created by Artem Mayer on 03.04.2023.
//

import Foundation
import FirebaseAnalytics

// MARK: - AnalyticsEvent

enum AnalyticsEvent {
    case loginFailed(String?)
    case loginSucceeded
    case logout
    case registrationFailed(String?)
    case registrationSucceeded
    case catalogViewed(page: Int, category: Int)
    case detailProductViewed(productId: Int)
    case productAddedToBasket(productId: Int)
    case productRemovedFromBasket(productId: Int)
    case basketSuccessfullyPaid
    case basketFailedPaid(String?)
    case reviewSuccessfullyAdded(productId: Int, reviewId: Int, userId: Int?)
    case reviewFailedAdded(productId: Int, reviewId: Int, userId: Int?)
    case serverError(String?)
}

// MARK: - Extensions

extension AnalyticsEvent {
    var name: String {
        switch self {
        case .loginFailed:
            return "loginFailed"
        case .loginSucceeded, .logout, .registrationSucceeded, .basketSuccessfullyPaid:
            return String(describing: self)
        case .registrationFailed:
            return "registrationFailed"
        case .catalogViewed:
            return "catalogListViewed"
        case .detailProductViewed:
            return "detailProductViewed"
        case .productAddedToBasket:
            return "productAddedToBasket"
        case .productRemovedFromBasket:
            return "productRemovedFromBasket"
        case .basketFailedPaid:
            return "basketFailedPaid"
        case .reviewSuccessfullyAdded:
            return "reviewSuccessfullyAdded"
        case .reviewFailedAdded:
            return "reviewFailedAdded"
        case .serverError:
            return "serverError"
        }
    }
}

extension AnalyticsEvent {
    var metadata: [String: String] {
        switch self {
        case .loginFailed(let errorMessage), .registrationFailed(let errorMessage),
                .basketFailedPaid(let errorMessage), .serverError(let errorMessage):
            return ["error": "\(errorMessage ?? "Unknown error")"]
        case .loginSucceeded, .logout,
                .registrationSucceeded, .basketSuccessfullyPaid:
            return [:]
        case .catalogViewed(let page, let category):
            return ["catalogPage": "\(page)", "catalogCategory": "\(category)"]
        case .detailProductViewed(let productId), .productAddedToBasket(let productId),
                .productRemovedFromBasket(let productId):
            return ["product": "\(productId)"]
        case .reviewSuccessfullyAdded(let productId, let reviewId, let userId),
                .reviewFailedAdded(let productId, let reviewId, let userId):
            guard let userId else {
                return ["product": "\(productId)", "review": "\(reviewId)"]
            }

            return ["product": "\(productId)", "review": "\(reviewId)", "user": "\(userId)"]
        }
    }
}
