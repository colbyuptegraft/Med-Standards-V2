//  AirForceBookshelfViewController.swift
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

class AirForceBookshelfViewController: TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let navBarappearance = UINavigationBarAppearance()
            navBarappearance.configureWithOpaqueBackground()
            navBarappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.navBarItemColor]
            navBarappearance.backgroundColor = global.airForceColor
            
            self.navigationController?.navigationBar.standardAppearance = navBarappearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarappearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = global.airForceColor
        
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.navigationController?.navigationBar.backgroundColor = global.airForceColor
            self.tabBarController?.tabBar.backgroundColor = global.airForceColor
        }
        
        setupPDFListData()
        getPDFListFromFirebase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let navBarappearance = UINavigationBarAppearance()
            navBarappearance.configureWithOpaqueBackground()
            navBarappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.navBarItemColor]
            navBarappearance.backgroundColor = global.airForceColor
            
            self.navigationController?.navigationBar.standardAppearance = navBarappearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarappearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = global.airForceColor
        
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.navigationController?.navigationBar.backgroundColor = global.airForceColor
            self.tabBarController?.tabBar.backgroundColor = global.airForceColor
        }
    }
    
    override func setupPDFListData() {
        sectionTitles = [0 : "Main Documents", 1 : "Other Menus"]
        otherMenu = [global.bomcTitle, global.fsToolkitTitle, global.otherAfisTitle]
        localPDFFiles = Utils.createArrayList(path: global.airForceMainPath)
    }
    
    override func getPDFListFromFirebase() {
        let directoryPath = TabsDirectory.airForce.pathString + AirForceSectionType.main.pathString
        firebaseStorageManager.getFileList(from: directoryPath, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.firebasePDFList = success
            case .failure(let failure):
                debugPrint(failure)
            }
        })
    }
    
    override func comparePDFLists() {
        firebasePDFList.forEach { firebaseModelPDF in
            // If file not match we download new pdf file
            guard let matchFile = localPDFFiles.first(where: { $0.title == firebaseModelPDF.title }) else {
                saveNewFile(firebaseModelPDF: firebaseModelPDF)
                return
            }
            
            // Match file - continue check update date
            if firebaseModelPDF.lastUpdateString != matchFile.lastUpdate {
                // Download new updated file and replace old
                firebaseStorageManager.saveUpdatedFile(
                    firebasePDFModel: firebaseModelPDF,
                    pathToList: global.airForceMainPath
                ) { [weak self] result in
                    switch result {
                    case .success(let isSuccess):
                        if isSuccess {
                            self?.setupPDFListData()
                            self?.tableView.reloadData()
                        }
                    case .failure(let failure):
                        debugPrint(failure.localizedDescription)
                    }
                }
            }
        }
    }
    
    override func saveNewFile(firebaseModelPDF: FirebasePDFModel) {
        firebaseStorageManager.saveNewFile(
            firebasePDFModel: firebaseModelPDF,
            pathToList: global.airForceMainPath
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.setupPDFListData()
                self?.tableView.reloadData()
            case .failure(let error):
                debugPrint("Failed to save new file: \(error)")
            }
        }
    }
    
    // MARK: - TableViewDataSorce and TableViewDelegate
    
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
        return section == 0 ? localPDFFiles.count : otherMenu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell
        switch indexPath.section {
        case 0:
            cell = Utils.setCellText(
                cell: cell,
                title: localPDFFiles[indexPath.row].title,
                titleFont: global.cellTitleFont!,
                titleFontColor: global.cellTitleFontColor,
                detail: localPDFFiles[indexPath.row].subtitle,
                detailFont: global.cellDetailFont!,
                detailFontColor: global.cellDetailFontColor
            )
        case 1:
            cell = Utils.setCellTitle(
                cell: cell,
                title: otherMenu[indexPath.row],
                titleFont: global.cellTitleFont!,
                titleFontColor: global.cellTitleFontColor
            )
        default:
            cell.textLabel?.text = "Other"
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        switch indexPath.section {
        case 0:
            let selectedPDF = localPDFFiles[indexPath.row]
            global.selection = selectedPDF.fileName
            if selectedPDF.isUpdated,
               let fileURL = FilesStorageManager().retrieveFileURL(forKey: selectedPDF.fullName) {
                global.url = fileURL
            } else {
                global.url = Bundle.main.url(forResource: global.airForceMainPath + global.selection, withExtension: "pdf")
            }
            // Check if URL valid and PDF document in on
            guard let docURL = global.url,
                  let pdfDocument = PDFDocument(url: docURL)
            else {
                showAlert(alertText: "Can't open document.", alertMessage: "Please, try again later.")
                return
            }
            global.url = docURL
            global.pdfDocument = pdfDocument
            goToSeque(with: "FromMainAirForceToPDFSegue")
        case 1:
            global.selection = otherMenu[(indexPath as NSIndexPath).row]
            if global.selection == global.bomcTitle {
                self.performSegue(withIdentifier: "ToBOMCMenuSegue", sender: Any?.self)
            } else if global.selection == global.fsToolkitTitle {
                self.performSegue(withIdentifier: "ToFSToolkitMenuSegue", sender: Any?.self)
            } else {
                self.performSegue(withIdentifier: "ToOtherAFIMenuSegue", sender: Any?.self)
            }
        default:
            self.performSegue(withIdentifier: "FromMainAirForceToPDFSegue", sender: Any?.self)
        }
    }
}
