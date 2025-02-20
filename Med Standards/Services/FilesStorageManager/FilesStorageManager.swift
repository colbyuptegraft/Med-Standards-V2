//
//  FilesStorageManager.swift
//  Med Standards
//
//  Created by Oleksandr on 19.02.2025.
//  Copyright © 2025 Doc Apps LLC. All rights reserved.
//

import Foundation
import UIKit

final class FilesStorageManager {
    
    // MARK: - Public method
    
    public func isFileExist(fileName: String) -> Bool {
        guard let urlForSaveFile = filePath(forKey: fileName) else { return false }
        
        return FileManager.default.fileExists(atPath: urlForSaveFile.path)
    }
    
//    public func newerFileExist(with title: String) -> URL? {
//        do {
//            let documentsDirectory = getDocumentsDirectory()
//            let directoryContents = try FileManager.default.contentsOfDirectory(
//                at: documentsDirectory,
//                includingPropertiesForKeys: nil
//            )
//            
//            if let oldFileExistURL = directoryContents.first(where: { $0.lastPathComponent.contains(title) }),
//               FileManager.default.fileExists(atPath: oldFileExistURL.path) {
//                return oldFileExistURL
//            } else {
//                return nil
//            }
//        } catch {
//            return nil
//        }
//    }
    
    // Delete file
    public func deleteOldFile(with title: String, completion: ((_ success: Bool) -> Void)? = nil) {
        do {
            let documentsDirectory = getDocumentsDirectory()
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentsDirectory,
                includingPropertiesForKeys: nil
            )
            
            if let oldFileExistURL = directoryContents.first(where: { $0.lastPathComponent.contains(title) }),
               FileManager.default.fileExists(atPath: oldFileExistURL.path) {
                try FileManager.default.removeItem(at: oldFileExistURL)
                completion?(true)
            } else {
                completion?(true)
            }
        } catch {
            completion?(false)
        }
    }
    
    
    // Store file for key
//    public func storeFile(with url: URL?, for key: String) {
//        guard let fileUrl = url,
//              let urlForSaveFile = filePath(forKey: key)
//        else { return }
//        
//        if let videoData = try? Data(contentsOf: fileUrl) {
//            do {
//                try videoData.write(to: urlForSaveFile, options: .atomic)
//            } catch let err {
//                print("Saving results in error: ", err)
//            }
//        }
//    }
    
//    public func storeFileToTempDir(with url: URL?, for key: String) {
//        guard let fileUrl = url
////              let urlForSaveFile = filePath(forKey: key)
//        else { return }
//        
//        let urlForSaveFile = getTempDirectoryPath().appendingPathComponent(key)
//        
//        if let videoData = try? Data(contentsOf: fileUrl) {
//            do {
//                try videoData.write(to: urlForSaveFile, options: .atomic)
//            } catch let err {
//                print("Saving results in error: ", err)
//            }
//        }
//    }
    
    // Store file with URL
//    public func storeFile(with url: URL?) {
//        guard let fileUrl = url,
//              let key = url?.absoluteString.components(separatedBy: "/").last,
//              let urlForSaveFile = filePath(forKey: key)
//        else { return }
//        
//        if let videoData = try? Data(contentsOf: fileUrl) {
//            do {
//                try videoData.write(to: urlForSaveFile, options: .atomic)
//            } catch let err {
//                print("Saving results in error: ", err)
//            }
//        }
//    }
    
    // Store file with Data
//    public func storeFile(with data: Data, for key: String) {
//        guard let urlForSaveFile = filePath(forKey: key) else { return }
//        
//        do {
//            try data.write(to: urlForSaveFile, options: .atomic)
//        } catch let err {
//            print("Saving results in error: ", err)
//        }
//    }
    
    // Store file with Data
//    public func storeFileToTempDir(with data: Data, for key: String) {
//        let urlForSaveFile = getTempDirectoryPath().appendingPathComponent(key)
////        guard let urlForSaveFile = filePath(forKey: key) else { return }
//        
//        do {
//            try data.write(to: urlForSaveFile, options: .atomic)
//        } catch let err {
//            print("Saving results in error: ", err)
//        }
//    }
    
    // Store image
//    func store(image: UIImage, forKey key: String) {
//        if let jpegRepresentation = image.jpegData(compressionQuality: 1) {
//            if let filePath = filePath(forKey: key) {
//                do {
//                    try jpegRepresentation.write(to: filePath, options: .atomic)
//                } catch let err {
//                    print("Saving results in error: ", err)
//                }
//            }
//        }
//    }
    
    // Delete file
//    public func deleteFile(for key: String,
//                           completion: ((_ success: Bool) -> Void)? = nil) {
//        if let filePath = filePath(forKey: key),
//           !key.isEmpty,
//           FileManager.default.fileExists(atPath: filePath.path) {
//            do {
//                try FileManager.default.removeItem(at: filePath)
//                completion?(true)
//            } catch let error {
//                print("deleting error:", error)
//                completion?(false)
//            }
//        } else {
//            completion?(false)
//        }
//    }
    
    // Retrieve file Data
//    public func retrieveFileData(forKey key: String) -> Data? {
//        if let filePath = filePath(forKey: key),
//            let fileData = FileManager.default.contents(atPath: filePath.path) {
//            return fileData
//        } else {
//            return nil
//        }
//    }
    
    // Retrieve image
//    func retrieveImage(forKey key: String) -> UIImage? {
//        if let filePath = self.filePath(forKey: key),
//            let fileData = FileManager.default.contents(atPath: filePath.path),
//            let image = UIImage(data: fileData) {
//            return image
//        } else {
//            return nil
//        }
//    }
    
    // Retrieve file URL
    public func retrieveFileURL(forKey key: String) -> URL? {
        return filePath(forKey: key)
    }
    
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // Get user's cache directory path
//    public func getCacheDirectoryPath() -> URL {
//        let arrayPaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
//        let cacheDirectoryPath = arrayPaths[0]
//        return cacheDirectoryPath
//    }
    
    // Get user's temp directory path
//    public func getTempDirectoryPath() -> URL {
//        let tempDirectoryPath = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
//        return tempDirectoryPath
//    }
    
    // MARK: - Private method
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key)
    }
    
    // Helper method for test
    func getAllFiles() {
        do {
            let documentsDirectory = getDocumentsDirectory()
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentsDirectory,
                includingPropertiesForKeys: nil
            )
            //            let files = try contentsOfDirectory(atPath: documentsDirectory.path)
            for file in directoryContents {
                print(file)
            }
        } catch {
            print("Cannot delete file. Error: \(error.localizedDescription)")
        }
    }
    
}
