//
//  StoreKitStorage.swift
//  Med Standards
//
//  Created by Oleksandr on 20.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import Foundation

/// Протокол хранилища информации о статусе подписки пользователя
protocol StoreKitStorage: AnyObject {
    var expiryDate: Date? { get set }
    var isBoughtSubscription: Bool { get set }
    // Subscription rules
    var freeOpensCount: Int { get set }
}

extension LocalStorage: StoreKitStorage {
    
    // MARK: Public properties
    
    var expiryDate: Date? {
        get {
            return userDefaults.object(forKey: Keys.expiryDate.rawValue) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: Keys.expiryDate.rawValue)
        }
    }
    
    var isBoughtSubscription: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isBoughtSubscription.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isBoughtSubscription.rawValue)
        }
    }
    
    var freeOpensCount: Int {
        get {
            return userDefaults.integer(forKey: Keys.freeOpensCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.freeOpensCount.rawValue)
        }
    }
    
    // MARK: - Private properties
    
    private enum Keys: String {
        case expiryDate
        case isBoughtSubscription
        case freeOpensCount
    }
}
