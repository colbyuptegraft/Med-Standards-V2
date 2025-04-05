//
//  String+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 13.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

extension String {
    func substringBetweenParentheses() -> String {
        guard let startIndex = self.lastIndex(of: "("),
              let endIndex = self.lastIndex(of: ")") else {
            return ""
        }
        
        let substring = self[startIndex...endIndex] // String(string[startIndex...endIndex])
//        let cleanSubstring = substring.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        
        return String(substring)
    }
}



