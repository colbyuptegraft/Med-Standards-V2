//
//  SettingsItem.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import UIKit

extension SettingsVC {

    struct Setting {
        let title: String
        let image: UIImage?
    }

    enum SettingsItem: Int, CaseIterable {
        // SUBSCRIPTION REMOVAL: Remove these cases (lines 18-19)
        case getPremium
        case restorePurchase
        case rateApp
        case support
        case shareApp
        case privacyPolicy
        case about

        var title: String {
            switch self {
            // SUBSCRIPTION REMOVAL: Remove these cases (lines 28-31)
            case .getPremium:
                return "Get premium"
            case .restorePurchase:
                return "Restore purchase"
            case .rateApp:
                return "Rate app"
            case .support:
                return "Support"
            case .shareApp:
                return "Share app"
            case .privacyPolicy:
                return "Privacy policy"
            case .about:
                return "About"
            }
        }

        var image: UIImage? {
            switch self {
            // SUBSCRIPTION REMOVAL: Remove these cases (lines 47-49)
            case .getPremium:
                return UIImage(named: "premium")
            case .restorePurchase:
                return UIImage(named: "restore")
            case .rateApp:
                return UIImage(named: "rate")
            case .support:
                return UIImage(named: "support")
            case .shareApp:
                return UIImage(named: "share")
            case .privacyPolicy:
                return UIImage(named: "privacy")
            case .about:
                return UIImage(named: "about")
            }
        }

        static func getAllItems() -> [Setting] {
            SettingsItem.allCases.compactMap { makeModel(from: $0) }
        }

        private static func makeModel(from item: SettingsItem) -> Setting {
            .init(title: item.title, image: item.image)
        }
    }
}
