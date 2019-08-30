//  AirForceBookshelfViewController.swift
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

import UIKit
import PDFKit

var docList:Array<String> = []
var titleList:Array<String> = []
var detailList:Array<String> = []

var rowTitles = [Int: Array<String>]()
var rowDetails = [Int: Array<String>]()

let sectionTitles = [0 : "Main Documents", 1 : "Other Menus"]
let otherMenu = [global.fsToolkitTitle, global.otherAfisTitle]

class AirForceBookshelfViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docList = createArrayList(path: global.airForceMainPath).doc
        
        titleList = createArrayList(path: global.airForceMainPath).title
        rowTitles = [0 : titleList, 1 : [global.fsToolkitTitle, global.otherAfisTitle]]
        
        detailList = createArrayList(path: global.airForceMainPath).detail
        rowDetails = [0 : detailList, 1 : ["", ""]]
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        
        switch (indexPath.section) {
        case 0:
            global.selection = docList[(indexPath as NSIndexPath).row]
            global.url = Bundle.main.url(forResource: global.airForceMainPath + global.selection, withExtension: "pdf")
            global.pdfDocument = PDFDocument(url: global.url!)!
            self.performSegue(withIdentifier: "FromMainAirForceToPDFSegue", sender: Any?.self)
        case 1:
            global.selection = otherMenu[(indexPath as NSIndexPath).row]
            if global.selection == global.fsToolkitTitle {
                self.performSegue(withIdentifier: "ToFSToolkitMenuSegue", sender: Any?.self)
            } else {
                self.performSegue(withIdentifier: "ToOtherAFIMenuSegue", sender: Any?.self)
            }
        default:
            self.performSegue(withIdentifier: "FromMainAirForceToPDFSegue", sender: Any?.self)
        }
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        if section == 0 {
            count = docList.count
        } else {
            count = 2
        }
        
        return count!
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell
        
        let titleFont:UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let detailFont:UIFont? = UIFont(name: "Helvetica", size: 12.0)
        
        switch (indexPath.section)
        {
        case 0:
            let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (detailList[(indexPath as NSIndexPath).row] ), attributes: (NSDictionary(object: detailFont!, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
            detailText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, detailText.length))
            
            let title = NSMutableAttributedString(string: titleList[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont!, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
            title.append(detailText)
            cell.textLabel?.attributedText = title
        case 1:
            let title = NSMutableAttributedString(string: otherMenu[(indexPath as NSIndexPath).row] , attributes: (NSDictionary(object: titleFont!, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
            cell.textLabel?.attributedText = title
        default:
            cell.textLabel?.text = "Other"
        }
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}
