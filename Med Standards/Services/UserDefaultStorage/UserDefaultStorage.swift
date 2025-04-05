//
//  UserDefaultStorage.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import Foundation

protocol DefaultStorage {}

final class LocalStorage {
    
    static let shared = LocalStorage()

    // MARK: - Private Properties
    
    let userDefaults: UserDefaults

    // MARK: - Init

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}
