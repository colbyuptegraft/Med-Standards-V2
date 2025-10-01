//  AppDelegate.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2025 Doc Apps LLC - https://www.doc-apps.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  The Software is provided “As Is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.  In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the Software or the use of there dealings in the Software.
//
//  This license does not extend to any of the Portable Document Format (PDF) files included with the Software.  These PDF files may not be used, copied, modified, published, distributed, sublicense, and/or sold without the express permission of the United States Department of Defense.

import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // SwiftyStoreKit
//        checkSubscription()
        
        // Firebase
        FirebaseApp.configure()
        
        // Register for push notifications
        registerForPushNotifications(for: application)
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let sampleFilename = ""
        if let sampleFile = Bundle.main.url(forResource: sampleFilename, withExtension: nil) {
            let destination = documentDirectory.appendingPathComponent(sampleFilename)
            if !fileManager.fileExists(atPath: destination.path) {
                try? fileManager.copyItem(at: sampleFile, to: destination)
            }
        }
        if let launchOptions = launchOptions, let url = launchOptions[.url] as? URL {
            let destination = documentDirectory.appendingPathComponent(url.lastPathComponent)
            if !fileManager.fileExists(atPath: destination.path) {
                try? fileManager.copyItem(at: url, to: destination)
                NotificationCenter.default.post(name: .documentDirectoryDidChange, object: nil)
            }
        }
        UINavigationBar.appearance().barTintColor = global.airForceColor
        UINavigationBar.appearance().tintColor = global.navBarItemColor
        UITabBar.appearance().tintColor = global.tabBarSelectedItemColor
        
        UITabBar.appearance().unselectedItemTintColor = global.tabBarUnselectedItemColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.titleFontColor, NSAttributedString.Key.font: global.titleFont!]
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destination = documentDirectory.appendingPathComponent(url.lastPathComponent)
        if !fileManager.fileExists(atPath: destination.path) {
            try? fileManager.copyItem(at: url, to: destination)
            NotificationCenter.default.post(name: .documentDirectoryDidChange, object: nil)
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

// MARK: - SwiftyStoreKit

extension AppDelegate {
    func checkSubscription() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                        // Unlock content
                    case .failed, .purchasing, .deferred:
                        break // do nothing
                    @unknown default:
                        break
                }
            }
        }
        
        StoreKitService().verifySubscription()
        StoreKitService().getSubscriptionInfoFromAppStore()
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    private func registerForPushNotifications(for application: UIApplication) {
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        // [END register_for_notifications]
    }
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        debugPrint("Firebase registration token: \(String(describing: fcmToken))")
    }
    
    // [END refresh_token]
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // Handle the notification
        completionHandler()
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show the notification while app is in the foreground
        completionHandler([.badge, .sound])
    }
}
