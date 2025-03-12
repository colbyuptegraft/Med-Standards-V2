//
//  Date+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import Foundation

extension Date {
    func isInCurrentMonth() -> Bool {
        let calendar = Calendar.current
        let today = Date()
        
        // Get the month and year components of both the date and today
        let currentMonth = calendar.component(.month, from: today)
        
        let targetMonth = calendar.component(.month, from: self)
        
        // Return true if both the month and year match
        return currentMonth == targetMonth
    }
}
