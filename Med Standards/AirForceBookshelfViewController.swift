//  AirForceBookshelfViewController.swift
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

struct global {
    
    static var pdfDocument = PDFDocument()
    static var url: URL!
    static var selection:String = ""
    static var link:String = ""
    
}

struct AF {
    
    static let dlcTitle = "AFI 10-203"
    static let dlcDetail = "Duty Limiting Conditions (20 Nov 2014)"
    
    static let mesTitle = "AFI 48-123"
    static let mesDetail = "Medical Examinations & Standards (28 Jan 2018)"
    
    static let medsTitle = "Approved Med List"
    static let medsDetail = "Official Air Force Aerospace Medicine Approved Medications (24 May 2018)"
    
    static let otcMedsTitle = "OTC Approved Med List"
    static let otcMedsDetail = "Over-the-Counter Medications Not Requiring Flight Surgeon Approval (9 Jan 2014)"
    
    static let modMedsTitle = "MOD Approved Med List"
    static let modMedsDetail = "Approved Missile Operator Medications (24 May 2018)"
    
    static let msdTitle = "MSD"
    static let msdDetail = "Medical Standards Directory (24 May 2018 v2)"
    
    static let wgTitle = "Waiver Guide"
    static let wgDetail = "Air Force Waiver Guide (4 Jan 2018)"
    
    static let fsToolkitTitle = "Flight Surgeon Toolkit"
    static let fsToolkitDetail = "Useful Flight Medicine Resources"
    
    static let physExMtxTitle = "Physical Examination Matrix"
    static let physExMtxDetail = "Medical Standards & Medical Examination Requirements (Jan 2018)"
    
    static let otherTitle = "Other AFIs"
    static let otherDetail = "Other Flight-Surgeon-Pertinent Air Force Instructions"
    
}

class AirForceBookshelfViewController: UITableViewController {
    
    let DocArray:NSArray = [AF.dlcTitle, AF.mesTitle, AF.medsTitle, AF.fsToolkitTitle, AF.otcMedsTitle, AF.modMedsTitle, AF.msdTitle, AF.physExMtxTitle, AF.wgTitle,  AF.otherTitle]
    let DocDetailArray:NSArray = [AF.dlcDetail, AF.mesDetail, AF.medsDetail, AF.fsToolkitDetail, AF.otcMedsDetail, AF.modMedsDetail, AF.msdDetail, AF.physExMtxDetail, AF.wgDetail, AF.otherDetail]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        global.selection = DocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection != AF.otherTitle && global.selection != AF.fsToolkitTitle {
            if global.selection == AF.dlcTitle {
                global.url = Bundle.main.url(forResource: "AFI 10-203 Duty Limiting Conditions (20 Nov 2014)", withExtension: "pdf")
            } else if global.selection == AF.mesTitle {
                global.url = Bundle.main.url(forResource: "AFI 48-123 Medical Examinations & Standards (28 Jan 2018)", withExtension: "pdf")
            } else if global.selection == AF.medsTitle {
                global.url = Bundle.main.url(forResource: "AF Approved Med List (24 May 2018)", withExtension: "pdf")
            } else if global.selection == AF.otcMedsTitle {
                global.url = Bundle.main.url(forResource: "AF OTC Approved Med List (9 Jan 2014)", withExtension: "pdf")
            } else if global.selection == AF.modMedsTitle {
                global.url = Bundle.main.url(forResource: "AF Missile Operator Approved Med List (24 May 2018)", withExtension: "pdf")
            } else if global.selection == AF.msdTitle {
                global.url = Bundle.main.url(forResource: "AF Medical Standards Directory (24 May 2018 v2)", withExtension: "pdf")
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
        return DocArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookshelfCell

        let titleFont:UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let detailFont:UIFont? = UIFont(name: "Helvetica", size: 12.0)
        
        let detailText:NSMutableAttributedString = NSMutableAttributedString(string: "\n" + (DocDetailArray[(indexPath as NSIndexPath).row] as! String), attributes: (NSDictionary(object: detailFont!, forKey: NSAttributedStringKey.font as NSCopying) as! [NSAttributedStringKey : Any]))
        detailText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, detailText.length))
        
        let title = NSMutableAttributedString(string: DocArray[(indexPath as NSIndexPath).row] as! String, attributes: (NSDictionary(object: titleFont!, forKey: NSAttributedStringKey.font as NSCopying) as! [NSAttributedStringKey : Any]))
        
        title.append(detailText)
        
        cell.textLabel?.attributedText = title
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}
