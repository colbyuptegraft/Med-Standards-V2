//
//  BookshelfViewController.swift
//  BookReader
//
//  Created by Kishikawa Katsumi on 2017/07/03.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import PDFKit

struct global {
    
    static var pdfDocument = PDFDocument()
    static var url: URL!
    static var selection:String = ""
    static var link:String = ""
    
}

struct AF {
    
    static let dlcTitle = "AFI 10-203"
    static let dlcDetail = "Duty Limiting Conditions (20 Nov 2014)"
    static let dlcPDF = "AFI 10-203 Duty Limiting Conditions (20 Nov 2014)"
    
    static let mesTitle = "AFI 48-123"
    static let mesDetail = "Medical Examinations & Standards (28 Jan 2018)"
    static let mesPDF = "AFI 48-123 Medical Examinations & Standards (28 Jan 2018)"
    
    static let medsTitle = "Approved Med List"
    static let medsDetail = "Official Air Force Aerospace Medicine Approved Medications (24 May 2018)"
    static let medsPDF = "AF Approved Med List (24 May 2018)"
    
    static let otcMedsTitle = "OTC Approved Med List"
    static let otcMedsDetail = "Over-the-Counter Medications Not Requiring Flight Surgeon Approval (09 Jan 2014)"
    static let otcMedsPDF = "AF OTC Approved Med List (09 Jan 2014)"
    
    static let modMedsTitle = "MOD Approved Med List"
    static let modMedsDetail = "Approved Missile Operator Medications (24 May 2018)"
    static let modMedsPDF = "AF Missile Operator Approved Med List (24 May 2018)"
    
    static let msdTitle = "MSD"
    static let msdDetail = "Medical Standards Directory (24 May 2018)"
    static let msdPDF = "AF Medical Standards Directory (24 May 2018)"
    
    static let wgTitle = "Waiver Guide"
    static let wgDetail = "Air Force Waiver Guide (4 Jan 2018)"
    static let wgPDF = "AF Waiver Guide (4 Jan 2018)"
    
    static let fsToolkitTitle = "Flight Surgeon Toolkit"
    static let fsToolkitDetail = "Useful Flight Medicine Resources"
    
    static let physExMtxTitle = "Physical Examination Matrix"
    static let physExMtxDetail = "Medical Standards & Medical Examination Requirements (Jan 2018)"
    static let physExMtxPDF = "AF Physical Examination Matrix (Jan 2018)"
    
    static let otherTitle = "Other AFIs"
    static let otherDetail = "Other Flight-Surgeon-Pertinent Air Force Instructions"
    
}

class AirForceBookshelfViewController: UITableViewController {
    
    let AFDocArray:NSArray = [AF.dlcTitle, AF.mesTitle, AF.medsTitle, AF.fsToolkitTitle, AF.otcMedsTitle, AF.modMedsTitle, AF.msdTitle, AF.physExMtxTitle, AF.wgTitle,  AF.otherTitle]
    let AFDocDetailArray:NSArray = [AF.dlcDetail, AF.mesDetail, AF.medsDetail, AF.fsToolkitDetail, AF.otcMedsDetail, AF.modMedsDetail, AF.msdDetail, AF.physExMtxDetail, AF.wgDetail, AF.otherDetail]

    var documents = [PDFDocument]()

    let thumbnailCache = NSCache<NSURL, UIImage>()
    private let downloadQueue = DispatchQueue(label: "com.kishikawakatsumi.pdfviewer.thumbnail")

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.separatorInset.left = 56
       // refreshData()
       // NotificationCenter.default.addObserver(self, selector: #selector(documentDirectoryDidChange(_:)), name: .documentDirectoryDidChange, object: nil)
    }
    
    func docError() {
        let title = NSLocalizedString("Error", comment: "")
        let message = NSLocalizedString("Document not found.  Please contact ColbyCoApps@gmail.com.", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            NSLog("The simple alert's cancel action occured.")
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = AFDocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection != AF.otherTitle && global.selection != AF.fsToolkitTitle {
            if global.selection == AF.dlcTitle {
                global.url = Bundle.main.url(forResource: "AFI 10-203 Duty Limiting Conditions (20 Nov 2014)", withExtension: "pdf")
                print("AFI 10-203")
            } else if global.selection == AF.mesTitle {
                global.url = Bundle.main.url(forResource: "AFI 48-123 Medical Examinations & Standards (28 Jan 2018)", withExtension: "pdf")
            } else if global.selection == AF.medsTitle {
                global.url = Bundle.main.url(forResource: "AF Approved Med List (24 May 2018)", withExtension: "pdf")
            } else if global.selection == AF.otcMedsTitle {
                global.url = Bundle.main.url(forResource: "AF OTC Approved Med List (09 Jan 2014)", withExtension: "pdf")
            } else if global.selection == AF.modMedsTitle {
                global.url = Bundle.main.url(forResource: "AF Missile Operator Approved Med List (24 May 2018)", withExtension: "pdf")
                print("MODS Meds")
            } else if global.selection == AF.msdTitle {
                global.url = Bundle.main.url(forResource: "AF Medical Standards Directory (24 May 2018)", withExtension: "pdf")
            } else if global.selection == AF.physExMtxTitle {
                global.url = Bundle.main.url(forResource: "AF Physical Examination Matrix (Jan 2018)", withExtension: "pdf")
            } else if global.selection == AF.wgTitle {
                global.url = Bundle.main.url(forResource: "AF Waiver Guide (4 Jan 2018)", withExtension: "pdf")
            } else {
                docError()
            }
            global.pdfDocument = PDFDocument(url: global.url!)!
            self.performSegue(withIdentifier: "FromMainAirForceToPDFSegue", sender: Any?.self)
        } else if global.selection == AF.otherTitle {
            self.performSegue(withIdentifier: "ToOtherAFIMenuSegue", sender: Any?.self)
        } else if global.selection == AF.fsToolkitTitle {
            self.performSegue(withIdentifier: "ToFSToolkitMenuSegue", sender: Any?.self)
        } else {
            docError()
        }
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AFDocArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell

        
        let titleFont:UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let detailFont:UIFont? = UIFont(name: "Helvetica", size: 12.0)
        
        let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (AFDocDetailArray[(indexPath as NSIndexPath).row] as! String), attributes: (NSDictionary(object: detailFont!, forKey: NSAttributedStringKey.font as NSCopying) as! [NSAttributedStringKey : Any]))
        detailText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, detailText.length))
        
        let title = NSMutableAttributedString(string: AFDocArray[(indexPath as NSIndexPath).row] as! String, attributes: (NSDictionary(object: titleFont!, forKey: NSAttributedStringKey.font as NSCopying) as! [NSAttributedStringKey : Any]))
        
        title.append(detailText)
        
        cell.textLabel?.attributedText = title
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        
        return cell
        /*
        let document = documents[indexPath.row]
        if let documentAttributes = document.documentAttributes {
            if let title = documentAttributes["Title"] as? String {
                cell.title = title
            }
            if let author = documentAttributes["Author"] as? String {
                cell.author = author
            }
            if document.pageCount > 0 {
                if let page = document.page(at: 0), let key = document.documentURL as NSURL? {
                    cell.url = key

                    if let thumbnail = thumbnailCache.object(forKey: key) {
                        cell.thumbnail = thumbnail
                    } else {
                        downloadQueue.async {
                            let thumbnail = page.thumbnail(of: CGSize(width: 40, height: 60), for: .cropBox)
                            self.thumbnailCache.setObject(thumbnail, forKey: key)
                            if cell.url == key {
                                DispatchQueue.main.async {
                                    cell.thumbnail = thumbnail
                                }
                            }
                        }
                    }
                }
            }
        }
        return cell
 */
    }

/*
    private func refreshData() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let contents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        documents = contents.flatMap { PDFDocument(url: $0) }

        tableView.reloadData()
    }

    @objc func documentDirectoryDidChange(_ notification: Notification) {
        refreshData()
    }
 */
}
