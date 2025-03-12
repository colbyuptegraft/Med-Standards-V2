//
//  StoreKitService.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

//import Foundation
import SwiftyStoreKit
import UIKit

final class StoreKitService {
    // Properties
    private let sharedSecret = StoreKitConstants.sharedSecret
    private let allSubscriptionIDs = Set(StoreKitConstants.Subscription.allCases.map({ $0.identifier }))
    
    private var storeKitStorage: StoreKitStorage = LocalStorage.shared
    private let storeKitDataManager = StoreKitDataManager.shared
    
    private let appleValidator = AppleReceiptValidator(service: .production,
                                                       sharedSecret: StoreKitConstants.sharedSecret)
    
    // MARK: - Public methods
    
    public func verifySubscription() {
        guard let expiryDate = storeKitStorage.expiryDate else {
            storeKitStorage.isBoughtSubscription = false
            return
        }
        
        if expiryDate < Date() {
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                switch result {
                case .success(let receipt):
                    let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: self.allSubscriptionIDs,
                                                                            inReceipt: receipt)
                    switch purchaseResult {
                    case .purchased(let expiryDate, _):
                        self.storeKitStorage.isBoughtSubscription = true
                        self.storeKitStorage.expiryDate = expiryDate
                    case .expired( _,  _):
                        self.storeKitStorage.isBoughtSubscription = false
                    case .notPurchased:
                        self.storeKitStorage.isBoughtSubscription = false
                    }
                case .error(let error):
                    debugPrint("Receipt verification failed: \(error)")
                    self.storeKitStorage.isBoughtSubscription = false
                }
            }
        }
    }
    
    public func getSubscriptionInfoFromAppStore() {
        fillDataArrays()
        
        SwiftyStoreKit.retrieveProductsInfo(allSubscriptionIDs) { result in
            if !result.retrievedProducts.isEmpty {
                let retrievedProducts = result.retrievedProducts
                for product in retrievedProducts {
                    debugPrint("DEBUG SwiftyStoreKit SUBSCRIPTION: ", product.debugDescription)
                    for (index, subscription) in self.storeKitDataManager.subscriptionsArray.enumerated() {
                        if subscription.id == product.productIdentifier {
                            let currencyCode = product.priceLocale.currencyCode ?? "USD"
                            let roundedPrice = round(100 * product.price.doubleValue) / 100
                            self.storeKitDataManager.subscriptionsArray[index].price = roundedPrice
                            debugPrint("DEBUG SwiftyStoreKit: PRICE: \(self.storeKitDataManager.subscriptionsArray[index].price)")
                            
                            self.storeKitDataManager.subscriptionsArray[index].currency = currencyCode
                            
                            if let localizedPrice = product.localizedPrice {
                                self.storeKitDataManager.subscriptionsArray[index].localizedPrice = localizedPrice
                            }
                        }
                    }
                }
            } else if let invalidProductId = result.invalidProductIDs.first {
                debugPrint("Invalid product identifier: \(invalidProductId)")
            } else {
                debugPrint("Error: \(result.error.debugDescription)")
            }
        }
    }
    
    public func buySubscription(subscriptionId: String,
                                viewController: UIViewController,
                                stopAnimationCompletion: @escaping (() -> ()),
                                purchaseCompletion: (() -> Void)?
    ) {
        SwiftyStoreKit.purchaseProduct(subscriptionId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                debugPrint("Purchase Success: \(purchase.productId)")
                self.storeKitStorage.isBoughtSubscription = true
                self.storeKitStorage.expiryDate = Date()
                purchaseCompletion?()
            case .error(let error):
                stopAnimationCompletion()
                switch error.code {
                case .unknown:
                    debugPrint("Unknown error. Please contact support. \(error.userInfo.first?.value ?? "")")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Unknown error. Please contact support.")
                case .clientInvalid:
                    debugPrint("Not allowed to make the payment")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Not allowed to make the payment")
                case .paymentCancelled:
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Payment Cancelled")
                    break
                case .paymentInvalid:
                    debugPrint("The purchase identifier was invalid")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "The purchase identifier was invalid")
                case .paymentNotAllowed:
                    debugPrint("The device is not allowed to make the payment")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "The device is not allowed to make the payment")
                case .storeProductNotAvailable:
                    debugPrint("The product is not available in the current storefront")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "The product is not available in the current storefront")
                case .cloudServicePermissionDenied:
                    debugPrint("Access to cloud service information is not allowed")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed:
                    debugPrint("Could not connect to the network")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Could not connect to the network")
                case .cloudServiceRevoked:
                    print("User has revoked permission to use this cloud service")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "User has revoked permission to use this cloud service")
                default:
                    debugPrint((error as NSError).localizedDescription)
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "Oops! Something went wrong.")
                }
                case .deferred(purchase: _):
                debugPrint("Purchase in statuses postponed")
                viewController.showAlert(alertText: "❌",
                                         alertMessage: "Purchase in statuses deferred")
            }
        }
    }
    
    public func restore(viewController: UIViewController,
                        stopAnimationCompletion: @escaping (() -> ()),
                        purchaseCompletion: (() -> Void)?
    ) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                viewController.showAlert(alertText: "❌",
                                         alertMessage: "Restore Failed.")
            } else if results.restoredPurchases.count > 0 {
                self.verifySubscriptionReceipt(viewController: viewController,
                                               stopAnimationCompletion: stopAnimationCompletion,
                                               purchaseCompletion: purchaseCompletion)
            } else {
                viewController.showAlert(alertText: "❌",
                                         alertMessage: "Nothing to Restore")
            }
            stopAnimationCompletion()
        }
    }
    
    public func verifySubscriptionReceipt(viewController: UIViewController,
                                          stopAnimationCompletion: (() -> ())?,
                                          purchaseCompletion: (() -> Void)?
    ) {
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: self.allSubscriptionIDs, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, _):
                    self.storeKitStorage.isBoughtSubscription = true
                    self.storeKitStorage.expiryDate = expiryDate
                    purchaseCompletion?()
                case .expired(let expiryDate, let items):
                    debugPrint("is expired since \(expiryDate)\n\(items)\n")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "is expired since \(expiryDate)\n\(items)")
                    stopAnimationCompletion?()
                case .notPurchased:
                    debugPrint("The user has never purchased")
                    viewController.showAlert(alertText: "❌",
                                             alertMessage: "The user has never purchased")
                    stopAnimationCompletion?()
                }
            case .error(let error):
                debugPrint("Receipt verification failed: \(error)")
                viewController.showAlert(alertText: "❌",
                                         alertMessage: "Receipt verification failed")
                stopAnimationCompletion?()
            }
        }
    }
    
    // MARK: - Public methods
    
    private func fillDataArrays() {
        storeKitDataManager.subscriptionsArray = StoreKitConstants.SubscriptionModelArray.dataSource
    }
    
}
