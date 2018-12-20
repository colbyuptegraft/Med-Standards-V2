//  AirForceRSVBookshelfViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2018 Colby Uptegraft - https://www.colbycoapps.com
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
    
    let DocArray:NSArray = [RSV.OverviewTitle, RSV.r1aTitle, RSV.r1aNotesTitle, RSV.r1b1Title, RSV.r1b2Title, RSV.r1b3Title, RSV.r1b4Title, RSV.r1cTitle, RSV.r1dTitle, RSV.r1e1Title, RSV.r1e2Title, RSV.r2aTitle, RSV.r3aTitle, RSV.r4aTitle, RSV.r5aTitle]
    let DocDetailArray:NSArray = [RSV.OverviewDetail, RSV.r1aDetail, RSV.r1aNotesDetail, RSV.r1b1Detail, RSV.r1b2Detail, RSV.r1b3Detail, RSV.r1b4Detail, RSV.r1cDetail, RSV.r1dDetail, RSV.r1e1Detail, RSV.r1e2Detail, RSV.r2aDetail, RSV.r3aDetail, RSV.r4aDetail, RSV.r5aDetail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = DocArray[(indexPath as NSIndexPath).row] as! String
        
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
        return DocArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell
        
        
        let titleFont:UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let detailFont:UIFont? = UIFont(name: "Helvetica", size: 12.0)
        
        let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (DocDetailArray[(indexPath as NSIndexPath).row] as! String), attributes: (NSDictionary(object: detailFont!, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        detailText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, detailText.length))
        
        let title = NSMutableAttributedString(string: DocArray[(indexPath as NSIndexPath).row] as! String, attributes: (NSDictionary(object: titleFont!, forKey: NSAttributedString.Key.font as NSCopying) as! [NSAttributedString.Key : Any]))
        
        title.append(detailText)
        
        cell.textLabel?.attributedText = title
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}
