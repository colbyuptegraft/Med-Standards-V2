// CommonCode.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2019 Colby Uptegraft - https://www.colbycoapps.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  The Software is provided “As Is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.  In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the Software or the use of there dealings in the Software.
//
//  This license does not extend to any of the Portable Document Format (PDF) files included with the Software.  These PDF files may not be used, copied, modified, published, distributed, sublicense, and/or sold without the express permission of the United States Department of Defense.

import Foundation
import PDFKit
import UIKit

struct global {
    
    //Fonts & Colors
    static let cellTitleFont = UIFont(name: "Helvetica", size: 14.0)
    static let cellDetailFont = UIFont(name: "Helvetica", size: 12.0)
    
    //Variables used across classes that change
    static var pdfDocument = PDFDocument()
    static var url: URL!
    static var selection:String = ""
    static var link:String = ""
    
    //Document Folder Paths
    static let airForceMainPath =  "/pdfs/airForce/main/"
    static let airForceOtherAfisPath = "/pdfs/airForce/otherAfis/"
    static let airForceFsToolkitPath = "/pdfs/airForce/fsToolkit/"
    static let airForceRsvPath = "/pdfs/airForce/rsvs/"
    
    static let armyPath = "/pdfs/army/"
    static let navyPath = "/pdfs/navy/"
    
    //Extra menu options for Air Force main menu
    static let fsToolkitTitle = "Flight Surgeon Toolkit"
    static let otherAfisTitle = "Other AFIs"
    
    //Extra menu options for FS Toolkit Menu
    static let oxConvTitle = "Altitude Oxygen Converter"
    static let pracGuideTitle = "ASAMS Practice Guidelines"
    static let rsvTitle = "RSV Sample Briefings"
    
}

public class Utils {
    
    static func createArrayList(path: String) -> (doc: Array<String>, title: Array<String>, detail: Array<String>) {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath! + path
        var content:Array<String> = []
        var docArray:Array<String> = []
        var titleArray:Array<String> = []
        var detailArray:Array<String> = []
        
        do {
            content = try fileManager.contentsOfDirectory(atPath: path)
            content = content.sorted(by: <)
            for i in content {
                var k = i
                k = String(k.dropLast(4))
                docArray.append(k)
            }
        } catch {
            print("Contents at file path null")
        }
        
        for i in docArray {
            var k = i.components(separatedBy: "#")
            titleArray.append(k[0])
            detailArray.append(k[1])
        }
        
        return (docArray, titleArray, detailArray)
    }
    
    static func setCellText(cell: BookshelfCell, indexPath: IndexPath, titleList: Array<String>, titleFont: UIFont, detailList: Array<String>, detailFont: UIFont) -> BookshelfCell {
        
        let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (detailList[(indexPath as NSIndexPath).row] ), attributes: (NSDictionary(object: detailFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        detailText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, detailText.length))
        
        let title = NSMutableAttributedString(string: titleList[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        title.append(detailText)
        cell.textLabel?.attributedText = title
        
        return cell
    }
    
    static func setCellTitle(cell: BookshelfCell, indexPath: IndexPath, titleList: Array<String>, titleFont: UIFont) -> BookshelfCell {
        
        let title = NSMutableAttributedString(string: titleList[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        cell.textLabel?.attributedText = title
        
        return cell
    }
    /*
    func docError() {
        let title = NSLocalizedString("Error", comment: "")
        let message = NSLocalizedString("Document not found. Please contact ColbyCoApps@gmail.com.", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            NSLog("The simple alert's cancel action occured.")
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    */
}


