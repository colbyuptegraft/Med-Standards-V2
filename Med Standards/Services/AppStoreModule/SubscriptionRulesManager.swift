//
//  SubscriptionRulesManager.swift
//  Med Standards
//
//  Created by Oleksandr on 10.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import Foundation

final class SubscriptionRulesManager {
    
    // MARK: - Public properties
    
    var isMaxFreeOpensCountReached: Bool {
        get {
            return freeOpensCount >= maxFreeOpensCount
        }
    }
    
    // MARK: - Private properties
    
    private let storeKitStorage: StoreKitStorage = LocalStorage.shared
    private let maxFreeOpensCount = 10
    private lazy var freeOpensCount = storeKitStorage.freeOpensCount
    
    // MARK: - Public methods
    
    func incrementFreeOpensCount() {
        freeOpensCount += 1
        storeKitStorage.freeOpensCount = freeOpensCount
    }
}
