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
    var pathToList = ""
    
    // From firebase storage
    lazy var firebaseStorageManager = FirebaseStorageManager()
    private let pdfListStorage: PDFListStorage = LocalStorage.shared
    var firebasePDFList = [FirebasePDFModel]() {
        didSet {
            compareForUpdateAndDownloadFilesInPDFLists()
            compareForDeleteOldFilesInPDFLists()
        }
    }
    
    private let storeKitStorage: StoreKitStorage = LocalStorage.shared
    
    // MARK: - Public methods
    
    func goToSeque(with identifier: String, selectedIndexPath: IndexPath) {
        // Check active subscription or free opens count for month
        let subRulesManager = SubscriptionRulesManager()
        if storeKitStorage.isBoughtSubscription {
            self.performSegue(withIdentifier: identifier, sender: Any?.self)
            updatePDFList(with: selectedIndexPath)
        } else if subRulesManager.isMaxFreeOpensCountReached {
            let subscriptionVC = SubscriptionViewController()
            subscriptionVC.modalPresentationStyle = .fullScreen
            present(subscriptionVC, animated: true)
        } else {
            subRulesManager.incrementFreeOpensCount()
            self.performSegue(withIdentifier: identifier, sender: Any?.self)
            updatePDFList(with: selectedIndexPath)
        }
    }
    
    // MARK: Override methods
    
    func setupPDFListData() {}
    
    func getPDFListFromFirebase() {}
    
}

// MARK: - Private methods with Firebase storage

private extension TableViewController {
    func compareForUpdateAndDownloadFilesInPDFLists() {
        firebasePDFList.forEach { firebaseModelPDF in
            // If file not match we download new pdf file
            guard let matchFile = localPDFFiles.first(where: { $0.title == firebaseModelPDF.title }) else {
                saveNewFile(firebaseModelPDF: firebaseModelPDF)
                return
            }
            
            // Match file - continue check update date
            if firebaseModelPDF.lastUpdateString != matchFile.lastUpdate {
                // Download new updated file and replace old
                firebaseStorageManager.saveUpdatedFile(
                    firebasePDFModel: firebaseModelPDF,
                    pathToList: pathToList
                ) { [weak self] result in
                    switch result {
                    case .success(let isSuccess):
                        if isSuccess {
                            self?.setupPDFListData()
                            self?.tableView.reloadData()
                        }
                    case .failure(let failure):
                        debugPrint(failure.localizedDescription)
                    }
                }
            }
        }
    }
    
    func saveNewFile(firebaseModelPDF: FirebasePDFModel) {
        firebaseStorageManager.saveNewFile(
            firebasePDFModel: firebaseModelPDF,
            pathToList: pathToList
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.setupPDFListData()
                self?.tableView.reloadData()
            case .failure(let error):
                debugPrint("Failed to save new file: \(error)")
            }
        }
    }
    
    func compareForDeleteOldFilesInPDFLists() {
        localPDFFiles.forEach { localModelPDF in
            guard let _ = firebasePDFList.first(where: { $0.title == localModelPDF.title }) else {
                deleteOldFile(localPDFFileModel: localModelPDF)
                return
            }
        }
    }
    
    func deleteOldFile(localPDFFileModel: PDFFileModel) {
        firebaseStorageManager.removeDeletedOldFile(localPDFFileModel: localPDFFileModel) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                var pdfFileArray = self.pdfListStorage.getPDFArray(for: pathToList)
                if let index = pdfFileArray.firstIndex(where: { $0.fileName == localPDFFileModel.fileName }) {
                    pdfFileArray.remove(at: index)
                    self.pdfListStorage.setPDFArray(for: pathToList, array: pdfFileArray.sorted(by: { $0.title < $1.title}))
                }
                self.setupPDFListData()
                self.tableView.reloadData()
            case .failure(let error):
                debugPrint("Failed to save new file: \(error)")
            }
        }
    }
    
    func updatePDFList(with indexPath: IndexPath) {
        localPDFFiles[indexPath.row].isNeedShowStatusRecentlyAdded = false
        localPDFFiles[indexPath.row].isNeedShowStatusRecentlyUpdated = false
        pdfListStorage.setPDFArray(for: pathToList, array: localPDFFiles.sorted(by: { $0.title < $1.title }))
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
