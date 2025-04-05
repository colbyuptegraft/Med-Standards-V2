//
//  SubscriptionScreenProtocol.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import NVActivityIndicatorViewExtended
import UIKit

// MARK: - Subscriptions extension

enum SubscriptionActions {
    case buy
    case close
    case restore
}

protocol SubscriptionScreen: NVActivityIndicatorViewable where Self: UIViewController {}

extension SubscriptionScreen {
    func restoreAction(completion: @escaping (Bool) -> Void) {
        startAnimating(CGSize(width: 100, height: 100), type: .lineSpinFadeLoader)
        let stopAnimationCompletion = { [weak self] in
            guard let self = self else { return }
            
            self.stopAnimating()
            completion(false)
        }
        
        let purchaseCompletion = { [weak self] in
            guard let self = self else { return } // Success
            
            self.stopAnimating()
            completion(true)
        }
        
        StoreKitService().restore(
            viewController: self,
            stopAnimationCompletion: stopAnimationCompletion,
            purchaseCompletion: purchaseCompletion
        )
    }
    
    func buySubscription(id: String, completion: @escaping (Bool) -> Void) {
        startAnimating(CGSize(width: 100, height: 100), type: .lineSpinFadeLoader)
        
        StoreKitService().buySubscription(subscriptionId: id, viewController: self) { [weak self] in
            guard let self = self else { return }
            
            self.stopAnimating()
            completion(false)
        } purchaseCompletion: { [weak self] in
            guard let self = self else { return }
            
            self.stopAnimating()
            completion(true)
        }
    }
}
