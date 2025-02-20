//
//  SubscriptionRulesManager.swift
//  Med Standards
//
//  Created by Oleksandr on 10.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
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
    private let maxFreeOpensCount = 5
    private lazy var freeOpensCount = storeKitStorage.freeOpensCount
    
    // MARK: - Public methods
    
    func setupFreeOpensCount() {
        guard let lastOpenDate = storeKitStorage.lastOpenDocumentDate else { return }
        
        if !lastOpenDate.isInCurrentMonth() {
            resetFreeOpensCount()
        }
    }
    
    func incrementFreeOpensCount() {
        freeOpensCount += 1
        storeKitStorage.freeOpensCount = freeOpensCount
        storeKitStorage.lastOpenDocumentDate = Date()
    }
    
    // MARK: - Private methods
    
    private func resetFreeOpensCount() {
        freeOpensCount = 0
        storeKitStorage.freeOpensCount = freeOpensCount
    }
}
