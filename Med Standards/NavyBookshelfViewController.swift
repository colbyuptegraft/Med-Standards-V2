//  NavyBookshelfViewController.swift
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

import UIKit
import PDFKit

class NavyBookshelfViewController: UITableViewController {
    
    let sectionTitles = [0 : "Main Documents", 1 : "Other Menus"]
    let otherMenu = [global.navyWikiTitle]
    let docList = Utils.createArrayList(path: global.navyPath).doc
    let titleList = Utils.createArrayList(path: global.navyPath).title
    let detailList = Utils.createArrayList(path: global.navyPath).detail
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = global.navyColor
        self.tabBarController?.tabBar.barTintColor = global.navyColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = global.navyColor
        self.tabBarController?.tabBar.barTintColor = global.navyColor
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
            global.url = Bundle.main.url(forResource: global.navyPath + global.selection, withExtension: "pdf")
            global.pdfDocument = PDFDocument(url: global.url!)!
            self.performSegue(withIdentifier: "FromNavyToPDFSegue", sender: Any?.self)
        case 1:
            global.selection = otherMenu[(indexPath as NSIndexPath).row]
            global.webUrl = global.navyWikiLink
            self.performSegue(withIdentifier: "FromNavyToWebview", sender: Any?.self)
        default:
            self.performSegue(withIdentifier: "FromMainAirForceToPDFSegue", sender: Any?.self)
        }
    }
}
