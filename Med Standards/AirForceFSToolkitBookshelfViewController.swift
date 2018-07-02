//  AirForceFSToolkitBookshelfViewController.swift
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

struct FSTlkt {
    
    static let fsfogTitle = "Flying Operations Guide"
    static let fsfogDetail = "AF Flight Surgeon Flying Operations Guide (4 Oct 2013)"
    
    static let fsqrTitle = "Quick Reference Guide"
    static let fsqrDetail = "AF Flight Surgeon Quick Reference Guide (16 Feb 2016)"
    
    static let metalsTitle = "Sample METALS Table"
    static let metalsDetail = "Flight Surgeon Mission-Essential Tasks / Activities for Line Support Table (26 Jun 2014)"
    
    static let nutSupTitle = "Dietary Supplements"
    static let nutSupDetail = "Nutritional & Ergogenic Supplements: Guidance & Policy"
    
    static let flyPhaMtxTitle = "Fly PHA Exam Matrix"
    static let flyPhaMtxDetail = "Periodic Health Assessment Requirements for Flyers (4 Nov 2016)"
    
    static let oxConTitle = "Altitude Oxygen Converter"
    static let oxConDetail = "Converts Ground-Level FiO2 to Cabin-Altitude Needs for Aeromedical Evacuations"
    
    static let phsExMtxTitle = "Physical Exam Matrix"
    static let phsExMtxDetail = "Physical Examination Matrix for USAF Special Duty Exams (6 Oct 2017)"
    
    static let pracGuidTitle = "Practice Guidelines"
    static let pracGuidDetail = "American Society of Aerospace Medicine Specialists (ASAMS) Practice Guidelines"
    
    static let rsvTitle = "RSV Sample Briefings"
    static let rsvDetail = "Readiness Skills Verification (RSV) Briefings"
    
    static let sgpTitle = "SGP-earls (v10.15)"
    static let sgpDetail = "Overview of the Chief of Aerospace Medicine (SGP) Roles & Responsibilities"
    
    static let specDescTitle = "Speciality Descriptions"
    static let specDescDetail = "48AX, 48GX, 48RX, & 48VX Specialty Descriptions (30 Apr 2015)"
}

class AirForceFSToolkitBookshelfViewController: UITableViewController {
    
    let DocArray:NSArray = [FSTlkt.oxConTitle, FSTlkt.nutSupTitle, FSTlkt.flyPhaMtxTitle, FSTlkt.fsfogTitle, FSTlkt.fsqrTitle, FSTlkt.phsExMtxTitle, FSTlkt.pracGuidTitle, FSTlkt.rsvTitle, FSTlkt.sgpTitle, FSTlkt.metalsTitle, FSTlkt.specDescTitle]
    let DocDetailArray:NSArray = [FSTlkt.oxConDetail, FSTlkt.nutSupDetail, FSTlkt.flyPhaMtxDetail, FSTlkt.fsfogDetail, FSTlkt.fsqrDetail, FSTlkt.phsExMtxDetail, FSTlkt.pracGuidDetail, FSTlkt.rsvDetail, FSTlkt.sgpDetail, FSTlkt.metalsDetail, FSTlkt.specDescDetail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = DocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection != FSTlkt.oxConTitle && global.selection != FSTlkt.pracGuidTitle && global.selection != FSTlkt.rsvTitle {
            if global.selection == FSTlkt.phsExMtxTitle {
                global.url = Bundle.main.url(forResource: "Physical Examination Matrix (6 Oct 2017)", withExtension: "pdf")
            } else if global.selection == FSTlkt.fsfogTitle {
                global.url = Bundle.main.url(forResource: "AF Flight Surgeon Flying Operations Guide (4 Oct 2013)", withExtension: "pdf")
            } else if global.selection == FSTlkt.flyPhaMtxTitle {
                global.url = Bundle.main.url(forResource: "Fly PHA Exam Requirements Matrix (4 Nov 2016)", withExtension: "pdf")
            } else if global.selection == FSTlkt.metalsTitle {
                global.url = Bundle.main.url(forResource: "Sample METALS Table (26 Jun 2014)", withExtension: "pdf")
            } else if global.selection == FSTlkt.nutSupTitle {
                global.url = Bundle.main.url(forResource: "Dietary Supplements", withExtension: "pdf")
            } else if global.selection == FSTlkt.sgpTitle {
                global.url = Bundle.main.url(forResource: "SGP-earls (v10.15)", withExtension: "pdf")
            } else if global.selection == FSTlkt.fsqrTitle {
                global.url = Bundle.main.url(forResource: "AF Flight Surgeon Quick Reference (16 Feb 2016)", withExtension: "pdf")
            } else if global.selection == FSTlkt.specDescTitle {
                global.url = Bundle.main.url(forResource: "Specialty Description 48XX (30 Apr 2015)", withExtension: "pdf")
            } else {
                docError()
            }
            global.pdfDocument = PDFDocument(url: global.url!)!
            self.performSegue(withIdentifier: "FromFSToolkitToPDFSegue", sender: Any?.self)
        } else if global.selection == FSTlkt.oxConTitle {
            self.performSegue(withIdentifier: "FromFSToolkitToOxConvSegue", sender: Any?.self)
        } else if global.selection == FSTlkt.pracGuidTitle {
            self.performSegue(withIdentifier: "FromFSToolkitToWebview", sender: Any?.self)
        } else if global.selection == FSTlkt.rsvTitle {
            self.performSegue(withIdentifier: "FromFSToolkitToRSVSegue", sender: Any?.self)
        } else {
            docError()
        }
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
