//
//  AnalyticsManager.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    static let shared = AnalyticsManager()

    private init() {}

    func logEvent() {
        Analytics.logEvent("", parameters: [:])
    }
}
