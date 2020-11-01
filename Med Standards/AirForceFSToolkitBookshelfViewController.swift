//  AirForceFSToolkitBookshelfViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2020 Doc Apps LLC - https://www.doc-apps.com
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

class AirForceFSToolkitBookshelfViewController: UITableViewController {
    
    let sectionTitles = [0 : "Toolkit Documents", 1 : "Other Menus & Tools"]
    let otherMenu = [global.oxConvTitle, global.pracGuideTitle, global.rsvTitle]
    let docList = Utils.createArrayList(path: global.airForceFsToolkitPath).doc
    let titleList = Utils.createArrayList(path: global.airForceFsToolkitPath).title
    let detailList = Utils.createArrayList(path: global.airForceFsToolkitPath).detail
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = global.airForceColor
        self.tabBarController?.tabBar.barTintColor = global.airForceColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = global.airForceColor
        self.tabBarController?.tabBar.barTintColor = global.airForceColor
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = global.tableViewSectionColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = global.tableViewSectionFontColor
        header.textLabel?.font = global.tableViewSectionFont
    } 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        if section == 0 {
            count = docList.count
        } else {
            count = otherMenu.count
        }
        return count!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell
        switch (indexPath.section)
        {
        case 0:
            cell = Utils.setCellText(cell: cell, indexPath: indexPath, titleList: titleList, titleFont: global.cellTitleFont!, titleFontColor: global.cellTitleFontColor, detailList: detailList, detailFont: global.cellDetailFont!, detailFontColor: global.cellDetailFontColor)
        case 1:
            cell = Utils.setCellTitle(cell: cell, indexPath: indexPath, titleList: otherMenu, titleFont: global.cellTitleFont!, titleFontColor: global.cellTitleFontColor)
        default:
            cell.textLabel?.text = "Other"
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        switch (indexPath.section) {
        case 0:
            global.selection = docList[(indexPath as NSIndexPath).row]
            global.url = Bundle.main.url(forResource: global.airForceFsToolkitPath + global.selection, withExtension: "pdf")
            global.pdfDocument = PDFDocument(url: global.url!)!
            self.performSegue(withIdentifier: "FromFSToolkitToPDFSegue", sender: Any?.self)
        case 1:
            global.selection = otherMenu[(indexPath as NSIndexPath).row]
            if global.selection == global.oxConvTitle {
                self.performSegue(withIdentifier: "FromFSToolkitToOxConvSegue", sender: Any?.self)
            } else if global.selection == global.pracGuideTitle {
                global.webUrl = global.pracGuideLink
                self.performSegue(withIdentifier: "FromFSToolkitToWebview", sender: Any?.self)
            } else {
                self.performSegue(withIdentifier: "FromFSToolkitToRSVSegue", sender: Any?.self)
            }
        default:
            self.performSegue(withIdentifier: "FromFSToolkitToPDFSegue", sender: Any?.self)
        }
    }
}
