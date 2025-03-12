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
    
    // Retrieve file URL
    public func retrieveFileURL(forKey key: String) -> URL? {
        return filePath(forKey: key)
    }
    
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
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
