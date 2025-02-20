//
//  PDFListStorage.swift
//  Med Standards
//
//  Created by Oleksandr on 20.02.2025.
//  Copyright © 2025 Doc Apps LLC. All rights reserved.
//

import Foundation

protocol PDFListStorage {
    func getPDFArray(for key: String) -> [PDFFileModel]
    func setPDFArray(for key: String, array: [PDFFileModel])
}

extension LocalStorage: PDFListStorage {
    func getPDFArray(for key: String) -> [PDFFileModel] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        
        do {
            return try JSONDecoder().decode([PDFFileModel].self, from: data)
        } catch {
            print("Error decoding data: \(error)")
            return []
        }
    }
    
    func setPDFArray(for key: String, array: [PDFFileModel]) {
        if let encodedData = try? JSONEncoder().encode(array) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
}

// MARK: - Models

struct PDFFileModel: Codable {
    let title: String
    let subtitle: String
    let fullName: String
    let fileName: String
    let lastUpdate: String
    let isUpdated: Bool
}
