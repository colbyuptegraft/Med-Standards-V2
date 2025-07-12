//
//  UIView+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 10.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import UIKit

/// Create standard buttons for stack view (used on subscription screens: restore, termsOfUse, Privacy)
// SUBSCRIPTION REMOVAL: Remove or modify this comment (line 10)
extension UIView {
    public func createButtonsForStackView(title: String, titleColor: UIColor?, fontSize: CGFloat = 12) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor?.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        return button
    }
}

// MARK: - Shadows

extension UIView {
    func applyShadow(
        shadowOffSet: CGSize = CGSize(width: 0, height: 0),
        shadowOpacity: Float = 12,
        shadowRadius: CGFloat = 12,
        color: UIColor = .black
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
