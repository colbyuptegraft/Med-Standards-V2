//
//  TableViewController.swift
//  Med Standards
//
//  Created by Oleksandr on 17.02.2025.
//  Copyright © 2025 Doc Apps LLC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    var sectionTitles = [Int: String]()
    var otherMenu = [String]()
    var localPDFFiles = [PDFFileModel]()
    
    // From firebase storage
    lazy var firebaseStorageManager = FirebaseStorageManager()
    var firebasePDFList = [FirebasePDFModel]() {
        didSet {
            comparePDFLists()
        }
    }
    
    private let storeKitStorage: StoreKitStorage = LocalStorage.shared
    
    // MARK: - Public methods
    
    func goToSeque(with identifier: String) {
        // Check active subscription or free opens count for month
        let subRulesManager = SubscriptionRulesManager()
        if storeKitStorage.isBoughtSubscription {
            self.performSegue(withIdentifier: identifier, sender: Any?.self)
        } else if subRulesManager.isMaxFreeOpensCountReached {
            let subscriptionVC = SubscriptionViewController()
            subscriptionVC.modalPresentationStyle = .fullScreen
            present(subscriptionVC, animated: true)
        } else {
            subRulesManager.incrementFreeOpensCount()
            self.performSegue(withIdentifier: identifier, sender: Any?.self)
        }
    }
    
    func setupPDFListData() {}
    
    func getPDFListFromFirebase() {}
    
    func comparePDFLists() {}
    
    func saveNewFile(firebaseModelPDF: FirebasePDFModel) {}
    
}
