//
//  Untitled.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import Foundation
import StoreKit

final class AppRateManager {
    static func requestRate() {
        SKStoreReviewController.requestReviewInCurrentScene()
    }
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
