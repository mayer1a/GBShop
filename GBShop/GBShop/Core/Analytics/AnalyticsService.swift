//
//  Analytics.swift
//  GBShop
//
//  Created by Artem Mayer on 03.04.2023.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

/// Obliges to implement two methods for handling the sending of logs to ``Firebase`` - crashlitics or analytics
protocol AnalyticsEngine: AnyObject {
    func assertionFailure(_ message: String)
    func sendAnalyticsEvent(name: String, metadata: [String: String])
}

/// Firebase analytics handling service for crashlitics and analytics
final class AnalyticsService: AnalyticsEngine {

    // MARK: - Private properties

    private let crashlytics = Crashlytics.crashlytics()

    // MARK: - Functions

    func assertionFailure(_ message: String) {
        crashlytics.log(message)
    }

    func sendAnalyticsEvent(name: String, metadata: [String: String]) {
        Analytics.logEvent(name, parameters: metadata)
    }
}
