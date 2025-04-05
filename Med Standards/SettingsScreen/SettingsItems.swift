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
        case getPremium
        case restorePurchase
        case rateApp
        case support
        case shareApp
        case privacyPolicy
        case about

        var title: String {
            switch self {
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
            case .getPremium:
                return UIImage(systemName: "crown")
            case .restorePurchase:
                return UIImage(systemName: "arrow.counterclockwise")
            case .rateApp:
                return UIImage(systemName: "star")
            case .support:
                return UIImage(systemName: "envelope")
            case .shareApp:
                return UIImage(systemName: "square.and.arrow.up")
            case .privacyPolicy:
                return UIImage(systemName: "text.document")
            case .about:
                return UIImage(systemName: "info.circle")
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
