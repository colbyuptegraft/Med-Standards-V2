//
//  BookshelfViewController.swift
//  BookReader
//
//  Created by Kishikawa Katsumi on 2017/07/03.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import PDFKit

struct RSV {
    
    static let OverviewTitle = "RSV Overview"
    static let OverviewDetail = "RSV for 48XX Flight Surgeons (48A/48G/48R) (02 Jul 2014)"
    
    static let r1aTitle = "RSV-1A"
    static let r1aDetail = "Mishap Investigation"
    
    static let r1aNotesTitle = "RSV-1A Notes"
    static let r1aNotesDetail = "Mishap Investigation Slide Notes"
    
    static let r1b1Title = "RSV-1B1"
    static let r1b1Detail = "Aeromedical & Physiological Aspects of Acceleration"
    
    static let r1b2Title = "RSV-1B2"
    static let r1b2Detail = "Spatial Disorientation"

    static let r1b3Title = "RSV-1B3"
    static let r1b3Detail = "Barotrauma"

    static let r1b4Title = "RSV-1B4"
    static let r1b4Detail = "Decompression Sickness & Hypoxia"
    
    static let r1cTitle = "RSV-1C"
    static let r1cDetail = "Travel Medicine"
   
    static let r1dTitle = "RSV-1D"
    static let r1dDetail = "Water & Food Vulnerability"
   
    static let r1e1Title = "RSV-1E1"
    static let r1e1Detail = "Aeromedical Aspects of Night Operations"
   
    static let r1e2Title = "RSV-1E2"
    static let r1e2Detail = "Thermal Stresses in Fighter Aviation"
    
    static let r2aTitle = "RSV-2A"
    static let r2aDetail = "Medical Clearance for Aeromedical Evacuation"
    
    static let r3aTitle = "RSV-3A"
    static let r3aDetail = "Human Performance Sustainment"
    
    static let r4aTitle = "RSV-4A"
    static let r4aDetail = "Occupational Health Assessment"
    
    static let r5aTitle = "RSV-5A"
    static let r5aDetail = "Aeromedical Summaries"
   
}

class AirForceRSVBookshelfViewController: UITableViewController {
    
    let AFDocArray:NSArray = [RSV.OverviewTitle, RSV.r1aTitle, RSV.r1aNotesTitle, RSV.r1b1Title, RSV.r1b2Title, RSV.r1b3Title, RSV.r1b4Title, RSV.r1cTitle, RSV.r1dTitle, RSV.r1e1Title, RSV.r1e2Title, RSV.r2aTitle, RSV.r3aTitle, RSV.r4aTitle, RSV.r5aTitle]
    let AFDocDetailArray:NSArray = [RSV.OverviewDetail, RSV.r1aDetail, RSV.r1aNotesDetail, RSV.r1b1Detail, RSV.r1b2Detail, RSV.r1b3Detail, RSV.r1b4Detail, RSV.r1cDetail, RSV.r1dDetail, RSV.r1e1Detail, RSV.r1e2Detail, RSV.r2aDetail, RSV.r3aDetail, RSV.r4aDetail, RSV.r5aDetail]
    
    var documents = [PDFDocument]()
    
    let thumbnailCache = NSCache<NSURL, UIImage>()
    private let downloadQueue = DispatchQueue(label: "com.kishikawakatsumi.pdfviewer.thumbnail")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.separatorInset.left = 56
        // refreshData()
        // NotificationCenter.default.addObserver(self, selector: #selector(documentDirectoryDidChange(_:)), name: .documentDirectoryDidChange, object: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = AFDocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection == RSV.OverviewTitle {
            global.url = Bundle.main.url(forResource: "RSV Overview", withExtension: "pdf")
        } else if global.selection == RSV.r1aTitle {
            global.url = Bundle.main.url(forResource: "RSV-1A Mishap Investigation", withExtension: "pdf")
        } else if global.selection == RSV.r1aNotesTitle {
            global.url = Bundle.main.url(forResource: "RSV-1A Mishap Investigation (Slide Notes)", withExtension: "pdf")
        } else if global.selection == RSV.r1b1Title {
            global.url = Bundle.main.url(forResource: "RSV-1B1 Aeromedical and Physiologic Aspects of Acceleration", withExtension: "pdf")
        } else if global.selection == RSV.r1b2Title {
            global.url = Bundle.main.url(forResource: "RSV-1B2 Spatial Disorientation", withExtension: "pdf")
        } else if global.selection == RSV.r1b3Title {
            global.url = Bundle.main.url(forResource: "RSV-1B3 Barotrauma", withExtension: "pdf")
        } else if global.selection == RSV.r1b4Title {
            global.url = Bundle.main.url(forResource: "RSV-1B4 Decompression Sickness and Hypoxia", withExtension: "pdf")
        } else if global.selection == RSV.r1cTitle {
            global.url = Bundle.main.url(forResource: "RSV-1C Travel Medicine", withExtension: "pdf")
        } else if global.selection == RSV.r1dTitle {
            global.url = Bundle.main.url(forResource: "RSV-1D Water and Food Vulnerability", withExtension: "pdf")
        } else if global.selection == RSV.r1e1Title {
            global.url = Bundle.main.url(forResource: "RSV-1E1 Aeromedical Aspects of Night Operations", withExtension: "pdf")
        } else if global.selection == RSV.r1e2Title {
            global.url = Bundle.main.url(forResource: "RSV-1E2 Thermal Stresses in Fighter Aviation", withExtension: "pdf")
        } else if global.selection == RSV.r2aTitle {
            global.url = Bundle.main.url(forResource: "RSV-2A Medical Clearance for Aeromedical Evacuation", withExtension: "pdf")
        } else if global.selection == RSV.r3aTitle {
            global.url = Bundle.main.url(forResource: "RSV-3A Human Performance Sustainment", withExtension: "pdf")
        } else if global.selection == RSV.r4aTitle {
            global.url = Bundle.main.url(forResource: "RSV-4A Occupational Health Assessment", withExtension: "pdf")
        } else if global.selection == RSV.r5aTitle {
            global.url = Bundle.main.url(forResource: "RSV-5A Aeromedical Summaries", withExtension: "pdf")
        } else {
            docError()
        }
        global.pdfDocument = PDFDocument(url: global.url!)!
        self.performSegue(withIdentifier: "FromRSVToPDFSegue", sender: Any?.self)
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
    }
}
