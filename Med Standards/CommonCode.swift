// CommonCode.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2020 Colby Uptegraft - https://www.colbycoapps.com
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
    static let airForceColor = UIColor(red: 8/255.0, green: 84/255.0, blue: 156/255.0, alpha: 100.0/100.0)
    static let armyColor = UIColor(red: 23/255.0, green: 75/255.0, blue: 42/255.0, alpha: 100.0/100.0)
    static let navyColor = UIColor(red: 0/255.0, green: 56/255.0, blue: 130/255.0, alpha: 100.0/100.0)
    static let dodColor = UIColor(red: 106/255.0, green: 13/255.0, blue: 173/255.0, alpha: 100.0/100.0)
    static let aboutColor = UIColor.black
    
    static let titleFont = UIFont(name: "Helvetica-Bold", size: 20.0)
    static let titleFontColor = UIColor.white
    static let navBarItemColor = UIColor.white
    
    static let tabBarUnselectedItemColor = UIColor.lightGray
    static let tabBarSelectedItemColor = UIColor.white
    
    static let tableViewSectionFont = UIFont(name: "Helvetica-Bold", size: 17.0)
    static let tableViewSectionFontColor = UIColor.white
    static let searchViewFontColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 100.0/100.0)
    static let tableViewSectionColor = UIColor.gray
    
    static let cellTitleFont = UIFont(name: "Helvetica", size: 14.0)
    static let cellTitleFontColor = UIColor.black
    
    static let cellDetailFont = UIFont(name: "Helvetica", size: 12.0)
    static let cellDetailFontColor = UIColor.gray
    
    //Variables used across classes that change
    static var pdfDocument = PDFDocument()
    static var url:URL!
    static var webUrl:String = ""
    static var selection:String = ""
    static var link:String = ""
    
    //Document Folder Paths
    static let airForceMainPath =  "/pdfs/airForce/main/"
    static let airForceOtherAfisPath = "/pdfs/airForce/otherAfis/"
    static let airForceFsToolkitPath = "/pdfs/airForce/fsToolkit/"
    static let airForceRsvPath = "/pdfs/airForce/rsvs/"
    
    static let armyPath = "/pdfs/army/"
    static let navyPath = "/pdfs/navy/"
    static let dodPath = "/pdfs/dod/"
    
    //Extra menu options for Air Force main menu
    static let fsToolkitTitle = "Flight Surgeon Toolkit"
    static let otherAfisTitle = "Other AFIs"
    
    //Extra menu options for FS Toolkit Menu
    static let oxConvTitle = "Altitude Oxygen Converter"
    static let pracGuideTitle = "ASAMS Practice Guidelines"
    static let pracGuideLink = "http://www.asams.org/guidelines.html"
    static let rsvTitle = "RSV Sample Briefings"
    
    //Extra menu options for Navy Menu
    static let navyWikiTitle = "Navy Flight Surgeon Wiki"
    static let navyWikiLink = "http://knowyourchit.mywikis.net/wiki/Main_Page"
    
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
            let k = i.components(separatedBy: "#")
            titleArray.append(k[0])
            detailArray.append(k[1])
        }
        return (docArray, titleArray, detailArray)
    }
    
    static func setCellText(cell: BookshelfCell, indexPath: IndexPath, titleList: Array<String>, titleFont: UIFont, titleFontColor: UIColor, detailList: Array<String>, detailFont: UIFont, detailFontColor: UIColor) -> BookshelfCell {
        let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (detailList[(indexPath as NSIndexPath).row] ), attributes: (NSDictionary(object: detailFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        detailText.addAttribute(NSAttributedString.Key.foregroundColor, value: detailFontColor, range: NSMakeRange(0, detailText.length))
        let title = NSMutableAttributedString(string: titleList[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: titleFontColor, range: NSMakeRange(0, title.length))
        title.append(detailText)
        cell.textLabel?.attributedText = title
        return cell
    }
    
    static func setCellTitle(cell: BookshelfCell, indexPath: IndexPath, titleList: Array<String>, titleFont: UIFont, titleFontColor: UIColor) -> BookshelfCell {
        let title = NSMutableAttributedString(string: titleList[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: titleFontColor, range: NSMakeRange(0, title.length))
        cell.textLabel?.attributedText = title
        return cell
    }
}


