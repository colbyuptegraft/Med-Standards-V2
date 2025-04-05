//
//  UIviewController+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import SafariServices
import UIKit

// MARK: - Alerts

extension UIViewController {
    func showAlert(alertText: String,
                   alertMessage: String? = nil,
                   buttonTitle: String? = "OK",
                   action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            if let action = action { action() }
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(with title: String,
                   message: String,
                   actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Instantiate from storyboard

extension UIViewController {
    static func instantiateFromStoryboard(storyboardName: String, identifier: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
