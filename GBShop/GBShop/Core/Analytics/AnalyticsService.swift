//
//  Analytics.swift
//  GBShop
//
//  Created by Artem Mayer on 03.04.2023.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

protocol AnalyticsEngine: AnyObject {
    func assertionFailure(_ message: String)
    func sendAnalyticsEvent(name: String, metadata: [String: String])
}

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
