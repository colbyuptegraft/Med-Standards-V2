//  ArmyBookshelfViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2021 Doc Apps LLC - https://www.doc-apps.com
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

class ArmyBookshelfViewController: UITableViewController {
    
    let docList = Utils.createArrayList(path: global.armyPath).doc
    let titleList = Utils.createArrayList(path: global.armyPath).title
    let detailList = Utils.createArrayList(path: global.armyPath).detail
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let navBarappearance = UINavigationBarAppearance()
            navBarappearance.configureWithOpaqueBackground()
            navBarappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.navBarItemColor]
            navBarappearance.backgroundColor = global.armyColor
            
            self.navigationController?.navigationBar.standardAppearance = navBarappearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarappearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = global.armyColor
        
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.navigationController?.navigationBar.backgroundColor = global.armyColor
            self.tabBarController?.tabBar.backgroundColor = global.armyColor
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let navBarappearance = UINavigationBarAppearance()
            navBarappearance.configureWithOpaqueBackground()
            navBarappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.navBarItemColor]
            navBarappearance.backgroundColor = global.armyColor
            
            self.navigationController?.navigationBar.standardAppearance = navBarappearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarappearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = global.armyColor
        
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.navigationController?.navigationBar.backgroundColor = global.armyColor
            self.tabBarController?.tabBar.backgroundColor = global.armyColor
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell
       cell = Utils.setCellText(cell: cell, indexPath: indexPath, titleList: titleList, titleFont: global.cellTitleFont!, titleFontColor: global.cellTitleFontColor, detailList: detailList, detailFont: global.cellDetailFont!, detailFontColor: global.cellDetailFontColor)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = docList[(indexPath as NSIndexPath).row]
        global.url = Bundle.main.url(forResource: global.armyPath + global.selection, withExtension: "pdf")
        global.pdfDocument = PDFDocument(url: global.url!)!
        self.performSegue(withIdentifier: "FromArmyToPDFSegue", sender: Any?.self)
    }
}
