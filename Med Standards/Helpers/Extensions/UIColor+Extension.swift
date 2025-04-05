//
//  UIColor+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 10.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import UIKit

/// Используется для преобразования hex-кода в UIColor
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat? = nil) {
        var hex: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        var a: UInt64
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (rgbValue >> 4 & 0xF) * 17, (rgbValue >> 4 & 0xF) * 17, (rgbValue & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, rgbValue >> 16, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (rgbValue >> 24, rgbValue >> 16 & 0xFF, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)
        default: // gray as like systemGray
            (a, r, g, b) = (255, 123, 123, 129)
        }
        
        if let alpha = alpha, alpha >= 0, alpha <= 1 {
            a = UInt64(alpha * 255)
        }
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255)
    }

    /// HEX-код цвета
    ///
    /// Не учитывает alpha т.к. использующийся инициализатор `UIColor` из `hex`-строки не исполльзует альфа-код в HEX
    var hexString: String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255))
        )
        return hexString
    }
}
