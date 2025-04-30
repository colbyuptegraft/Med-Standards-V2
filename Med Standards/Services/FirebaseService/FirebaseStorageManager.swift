//
//  FirebaseStorageManager.swift
//  Med Standards
//
//  Created by Oleksandr on 12.02.2025.
//  Copyright © Doc Apps LLC. All rights reserved.
//

import FirebaseStorage
import PDFKit
import UIKit

final class FirebaseStorageManager {
    
    // MARK: - Private Properties
    
    private let storage = Storage.storage()
    private let filesStorageManager = FilesStorageManager()
    private let pdfListStorage: PDFListStorage = LocalStorage.shared
    
    // MARK: - Public methods
    
    func getFileList(
        from directory: String,
        completion: @escaping (Result<[FirebasePDFModel], FirebaseError>) -> Void
    ) {
        let pathReference = storage.reference(withPath: directory)
        
        pathReference.listAll { result, _ in
            guard let pdfList = result else {
                completion(.failure(.noPDFListFromFirebase))
                return
            }
            
            var documents = [FirebasePDFModel]()
            
            for item in pdfList.items {
                // The items under storageReference.
                let fileName = String(item.name.dropLast(4))
                let tittle = fileName.components(separatedBy: "#").first ?? ""
                let subtitle = fileName.components(separatedBy: "#").last ?? ""
                let docModel = FirebasePDFModel(fullName: item.name,
                                                title: tittle,
                                                subtitle: subtitle,
                                                lastUpdateString: item.name.substringBetweenParentheses(),
                                                url: item
                )
                documents.append(docModel)
            }
            completion(.success(documents))
        }
    }
    
    func saveUpdatedFile(
        firebasePDFModel: FirebasePDFModel,
        pathToList: String,
        completion: @escaping (Result<Bool, Error>
        ) -> Void) {
        // Remove outdated pdf file
        filesStorageManager.deleteOldFile(with: firebasePDFModel.title) { success in
            guard success else {
                completion(.success(false))
                return
            }
            
            // Write file to app directory
            let clearedFileName = firebasePDFModel.fullName.replacingOccurrences(of: "%20 ", with: " ")
            let newFileURL = self.filesStorageManager.getDocumentsDirectory().appendingPathComponent(clearedFileName)
            firebasePDFModel.url.write(toFile: newFileURL) { result in
                switch result {
                    case .success( _):
                        var pdfFileArray = self.pdfListStorage.getPDFArray(for: pathToList)
                        if let pdfFileIndex = pdfFileArray.firstIndex(where: { $0.title == firebasePDFModel.title }) {
                            let pdfFileUpdated = PDFFileModel(
                                title: firebasePDFModel.title,
                                subtitle: firebasePDFModel.subtitle,
                                fullName: firebasePDFModel.fullName,
                                fileName: String(firebasePDFModel.fullName.dropLast(4)),
                                lastUpdate: firebasePDFModel.lastUpdateString,
                                isUpdated: true,
                                isNeedShowStatusRecentlyUpdated: true,
                                isNeedShowStatusRecentlyAdded: false
                            )
                            pdfFileArray[pdfFileIndex] = pdfFileUpdated
                            debugPrint("saveUpdatedFile: , \(pdfFileUpdated)")
                            self.pdfListStorage.setPDFArray(for: pathToList, array: pdfFileArray.sorted(by: { $0.title < $1.title}))
                        }
                        completion(.success(true))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
    
    func saveNewFile(
        firebasePDFModel: FirebasePDFModel,
        pathToList: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        // Write file to app directory
        let clearedFileName = firebasePDFModel.fullName.replacingOccurrences(of: "%20 ", with: " ")
        let newFileURL = self.filesStorageManager.getDocumentsDirectory().appendingPathComponent(clearedFileName)
        firebasePDFModel.url.write(toFile: newFileURL) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success( _):
                    var pdfFileArray = self.pdfListStorage.getPDFArray(for: pathToList)
                    let pdfFileModel = PDFFileModel(
                        title: firebasePDFModel.title,
                        subtitle: firebasePDFModel.subtitle,
                        fullName: firebasePDFModel.fullName,
                        fileName: String(firebasePDFModel.fullName.dropLast(4)),
                        lastUpdate: firebasePDFModel.lastUpdateString,
                        isUpdated: true,
                        isNeedShowStatusRecentlyUpdated: false,
                        isNeedShowStatusRecentlyAdded: true
                    )
                    pdfFileArray.append(pdfFileModel)
                    self.pdfListStorage.setPDFArray(for: pathToList, array: pdfFileArray.sorted(by: { $0.title < $1.title}))
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func removeDeletedOldFile(
        localPDFFileModel: PDFFileModel,
        completion: @escaping (Result<Bool, Error>
        ) -> Void) {
        // Remove outdated pdf file
        filesStorageManager.deleteOldFile(with: localPDFFileModel.fullName) { success in
            completion(.success(success))
        }
    }
}

// MARK: - Firebase models

enum TabsDirectory {
    case airForce
    case army
    case navy
    case dod
    
    var pathString: String {
        switch self {
            case .airForce:
                return "PDFs/af"
            case .army:
                return "PDFs/army"
            case .navy:
                return "PDFs/navy"
            case .dod:
                return "PDFs/dod"
        }
    }
}

enum AirForceSectionType {
    case AFIs
    case RSVs
    case bomc
    case fsToolkit
    case main
    
    var pathString: String {
        switch self {
            case .AFIs:
                return "/AFIs"
            case .RSVs:
                return "/RSVs"
            case .bomc:
                return "/bomc"
            case .fsToolkit:
                return "/fsToolkit"
            case .main:
                return "/main"
        }
    }
}

struct FirebasePDFModel {
    let fullName: String
    let title: String
    let subtitle: String
    let lastUpdateString: String
    let url: StorageReference
}

// MARK: - Errors

enum FirebaseError: Error {
    case noPDFListFromFirebase
    
    var errorDescription: String {
        switch self {
            case .noPDFListFromFirebase:
                return "No PDF files list from Firebase"
        }
    }
}
