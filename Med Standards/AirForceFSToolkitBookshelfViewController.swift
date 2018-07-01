//
//  BookshelfViewController.swift
//  BookReader
//
//  Created by Kishikawa Katsumi on 2017/07/03.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import PDFKit

struct FSTlkt {
    
    static let fsfogTitle = "Flying Operations Guide"
    static let fsfogDetail = "AF Flight Surgeon Flying Operations Guide (4 Oct 2013)"
    static let fsfogPDF = "AF Flight Surgeon Flying Operations Guide (4 Oct 2013)"
    
    static let fsqrTitle = "Quick Reference Guide"
    static let fsqrDetail = "AF Flight Surgeon Quick Reference Guide (16 Feb 2016)"
    static let fsqrPDF = "AF Flight Surgeon Quick Reference (16 Feb 2016)"
    
    static let metalsTitle = "Sample METALS Table"
    static let metalsDetail = "Flight Surgeon Mission-Essential Tasks / Activities for Line Support Table (26 Jun 2014)"
    static let metalsPDF = "Sample METALS Table (26 Jun 2014)"
    
    static let nutSupTitle = "Dietary Supplements"
    static let nutSupDetail = "Nutritional & Ergogenic Supplements: Guidance & Policy"
    static let nutSupPDF = "Dietary Supplements"
    
    static let flyPhaMtxTitle = "Fly PHA Exam Matrix"
    static let flyPhaMtxDetail = "Periodic Health Assessment Requirements for Flyers (4 Nov 2016)"
    static let flyPhaMtxPDF = "Fly PHA Exam Requirements Matrix (4 Nov 2016)"
    
    static let oxConTitle = "Altitude Oxygen Converter"
    static let oxConDetail = "Converts Ground-Level FiO2 to Cabin-Altitude Needs for Aeromedical Evacuations"
    
    static let phsExMtxTitle = "Physical Exam Matrix"
    static let phsExMtxDetail = "Physical Examination Matrix for USAF Special Duty Exams (6 Oct 2017)"
    static let phsExMtxPDF = "Physical Examination Matrix (6 Oct 2017)"
    
    static let pracGuidTitle = "Practice Guidelines"
    static let pracGuidDetail = "American Society of Aerospace Medicine Specialists (ASAMS) Practice Guidelines"
    
    static let rsvTitle = "RSV Sample Briefings"
    static let rsvDetail = "Readiness Skills Verification (RSV) Briefings"
    
    static let sgpTitle = "SGP-earls (v10.15)"
    static let sgpDetail = "Overview of the Chief of Aerospace Medicine (SGP) Roles & Responsibilities"
    static let sgpPDF = "SGP-earls (v10.15)"
    
    static let specDescTitle = "Speciality Descriptions"
    static let specDescDetail = "48AX, 48GX, 48RX, & 48VX Specialty Descriptions (30 Apr 2015)"
    static let specDescPDF = "Specialty Description 48XX (30 Apr 2015)"
}

class AirForceFSToolkitBookshelfViewController: UITableViewController {
    
    let AFDocArray:NSArray = [FSTlkt.oxConTitle, FSTlkt.nutSupTitle, FSTlkt.flyPhaMtxTitle, FSTlkt.fsfogTitle, FSTlkt.fsqrTitle, FSTlkt.phsExMtxTitle, FSTlkt.pracGuidTitle, FSTlkt.rsvTitle, FSTlkt.sgpTitle, FSTlkt.metalsTitle, FSTlkt.specDescTitle]
    let AFDocDetailArray:NSArray = [FSTlkt.oxConDetail, FSTlkt.nutSupDetail, FSTlkt.flyPhaMtxDetail, FSTlkt.fsfogDetail, FSTlkt.fsqrDetail, FSTlkt.phsExMtxDetail, FSTlkt.pracGuidDetail, FSTlkt.rsvDetail, FSTlkt.sgpDetail, FSTlkt.metalsDetail, FSTlkt.specDescDetail]
    
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
