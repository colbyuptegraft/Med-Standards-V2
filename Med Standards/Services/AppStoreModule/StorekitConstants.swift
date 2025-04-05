//
//  StorekitConstants.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import Foundation
import UIKit

final class StoreKitDataManager {
    static let shared = StoreKitDataManager()
    var subscriptionsArray = [SubscriptionModel]()
    
    func getSubscriptionModel(for identifier: String) -> SubscriptionModel? {
        let model = subscriptionsArray.first(where: { $0.id == identifier })
        return model
    }
}

struct SubscriptionModel {
    let id: String
    var price: Double
    var localizedPrice: String
    let durationType: DurationType
    let duration: String
    var currency: String
}

enum DurationType {
    case month
}

struct StoreKitConstants {
    static let sharedSecret = "107101404542437aa99d748ab4cd80c5"

    enum Subscription: Int, CaseIterable {
        case month

        var identifier: String {
            switch self {
            case .month:
                return "com.ColbyCo.MedStandards.subscriptionMonth"
            }
        }

        var estimatedPrice: Double {
            switch self {
            case .month:
                return 0.99
            }
        }
        
        var durationType: DurationType {
            switch self {
            case .month:
                return .month
            }
        }

        var duration: String {
            switch self {
            case .month:
                return "/month"
            }
        }
    }
    
    struct SubscriptionModelArray {
        private static func model(for subscription: Subscription) -> SubscriptionModel {
            return SubscriptionModel(
                id: subscription.identifier,
                price: subscription.estimatedPrice,
                localizedPrice: String(format: "$%.2f", subscription.estimatedPrice),
                durationType: subscription.durationType,
                duration: subscription.duration,
                currency: "$"
            )
        }

        static let dataSource = [
            SubscriptionModelArray.model(for: .month)
        ]
    }
}
