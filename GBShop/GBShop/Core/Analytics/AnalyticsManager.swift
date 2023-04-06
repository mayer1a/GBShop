//
//  AnalyticsManager.swift
//  GBShop
//
//  Created by Artem Mayer on 03.04.2023.
//

import Foundation

/// Obliges to implement the event logging method for ``Firebase`` - crashlitics and analytics based on the ``AnalyticsEvent``.
protocol AnalyticsManagerInterface: AnyObject {
    func log(_ event: AnalyticsEvent)
}

/// Firebase analytics event logging manager
final class AnalyticsManager: AnalyticsManagerInterface {

    // MARK: - Private properties

    private let service: AnalyticsEngine

    // MARK: - Constructions

    init(service: AnalyticsEngine) {
        self.service = service
    }

    // MARK: - Functions

    func log(_ event: AnalyticsEvent) {
        switch event {
        case .loginFailed, .registrationFailed, .basketFailedPaid, .reviewFailedAdded, .serverError:
            service.assertionFailure(event.name)
        case .loginSucceeded, .logout, .registrationSucceeded,
                .catalogViewed, .detailProductViewed, .productAddedToBasket,
                .productRemovedFromBasket, .basketSuccessfullyPaid, .reviewSuccessfullyAdded:
            service.sendAnalyticsEvent(name: event.name, metadata: event.metadata)
        }
    }
}
