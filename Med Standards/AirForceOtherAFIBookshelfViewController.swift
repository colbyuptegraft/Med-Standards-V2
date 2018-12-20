//  AirForceOtherAFIBookshelfViewController.swift
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

struct OtherAFI {
    
    static let afi10203sgTitle = "AFI 10-203 Supplemental Guidance"
    static let afi10203sgDetail = "Supplemental Guidance for DLCs (17 Nov 2016)"

    static let afi10203sgtTitle = "AFI 10-203 Supplemental Profile Timelines"
    static let afi10203sgtDetail = "Timelines for DLCs (Jun 2014)"

    static let afi10203sgtmTitle = "AFI 10-203 Supplemental Profile Templates"
    static let afi10203sgtmDetail = "Templates for DLCs (4 Dec 2016)"

    static let afi11202v1Title = "AFI 11-202 v1"
    static let afi11202v1Detail = "Aircrew Training (14 Jun 2018)"

    static let afi11202v2Title = "AFI 11-202 v2"
    static let afi11202v2Detail = "Aircrew Standardization and Evaluation Program (18 Dec 2018)"

    static let afi11202v3Title = "AFI 11-202 v3"
    static let afi11202v3Detail = "General Flight Rules (2 Oct 2018)"

    static let afi11301v1Title = "AFI 11-301 v1"
    static let afi11301v1Detail = "Aircrew Flight Equipment (AFE) Program (10 Oct 2017)"

    static let afi11301v2Title = "AFI 11-301 v2"
    static let afi11301v2Detail = "Management & Configuration Requirements for Aircrew Flight Equipment (AFE) (6 Dec 2017)"

    static let afi11301v4Title = "AFI 11-301 v4 (Rescinded)"
    static let afi11301v4Detail = "Aircrew Laser Eye Protection (ALEP) (17 Feb 2010)"

    static let afi11401Title = "AFI 11-401"
    static let afi11401Detail = "Aviation Management (30 Aug 2018)"

    static let afi11402Title = "AFI 11-402"
    static let afi11402Detail = "Aviation & Parachutist Service, Aeronautical Ratings & Aviation Badges (28 Feb 2018)"
    
    static let afi11403Title = "AFI 11-403"
    static let afi11403Detail = "Aerospace Physiological Training Program (25 Mar 2015)"
    
    static let afi11404Title = "AFI 11-404"
    static let afi11404Detail = "Fighter Aircrew Acceleration Training Program (9 Jun 2017)"
    
    static let afi11409Title = "AFI 11-409"
    static let afi11409Detail = "High Altitude Airdrop Mission Support Program (9 Sep 2015)"

    static let afi362101Title = "AFI 36-2101"
    static let afi362101Detail = "Classifying Military Personnel (9 Mar 2017)"

    static let afi362905Title = "AFI 36-2905"
    static let afi362905Detail = "Fitness Program (27 Aug 2015)"
    
    static let afi362910Title = "AFI 36-2910"
    static let afi362910Detail = "LOD Determination, Medical Continuation, & Incapacitation Pay (8 Oct 2015)"

    static let afi44103Title = "AFI 44-103"
    static let afi44103Detail = "Air Force IDMT Program (30 Aug 2018)"

    static let afi44170Title = "AFI 44-170"
    static let afi44170Detail = "Preventive Health Assessment (19 Jan 2016)"

    static let afi44171Title = "AFI 44-171"
    static let afi44171Detail = "Patient Centered Medical Home Operations (28 Nov 2014)"

    static let afi44172Title = "AFI 44-172"
    static let afi44172Detail = "Mental Health (13 Nov 2015)"

    static let afi48101Title = "AFI 48-101"
    static let afi48101Detail = "Aerospace Medicine Enterprise (8 Dec 2014)"

    static let afi48145Title = "AFI 48-145"
    static let afi48145Detail = "Occupational & Environmental Health Program (11 Jul 2018)"

    static let afi48149Title = "AFI 48-149"
    static let afi48149Detail = "Flight & Operational Medicine Program (FOMP) (18 Dec 2015)"

    static let afi48307v1Title = "AFI 48-307 v1"
    static let afi48307v1Detail = "En Route Care & Aeromedical Evacuation Medical Operations (9 Jan 2017)"

    static let afi48307v2Title = "AFI 48-307 v2"
    static let afi48307v2Detail = "En Route Critical Care (10 Jan 2017)"

    static let afi48307v3Title = "AFI 48-307 v3"
    static let afi48307v3Detail = "En Route Care Documentation (12 Apr 2016)"

    static let afi91202Title = "AFI 91-202"
    static let afi91202Detail = "The US Air Force Mishap Prevention Program (21 May 2018)"

    static let afi91204Title = "AFI 91-204"
    static let afi91204Detail = "Safety Investigations & Reports (27 Apr 2018)"

    static let aetci48102Title = "AETCI 48-102"
    static let aetci48102Detail = "Medical Management of Undergraduate Flying Students (5 Nov 2013)"

    static let aetci48103Title = "AETCI 48-103"
    static let aetci48103Detail = "Training Health & Human Performance (24 Apr 2018)"

    static let afecdTitle = "AFECD"
    static let afecdDetail = "Air Force Enlisted Classification Directory (31 Oct 2018)"
    
    static let afman48146Title = "AFMAN 48-146"
    static let afman48146Detail = "Occupational & Environmental Health Program Management (15 Oct 2018)"

    static let afman48147Title = "AFMAN 48-147"
    static let afman48147Detail = "Tri-Service Food Code (30 Apr 2014)"

    static let afman91223Title = "AFMAN 91-223"
    static let afman91223Detail = "Aviation Safety Investigations & Reports (14 Sep 2018)"

    static let afocdTitle = "AFOCD"
    static let afocdDetail = "Air Force Officer Classification Directory (31 Oct 2018)"

    static let afpam48133Title = "AFPAM 48-133 (Rescinded)"
    static let afpam48133Detail = "Physical Examination Techniques (1 Jun 2000)"

    static let afpd481Title = "AFPD 48-1"
    static let afpd481Detail = "Aerospace Medicine Enterprise (23 Aug 2011)"

}

class AirForceOtherAFIBookshelfViewController: UITableViewController {
    
    let DocArray:NSArray = [OtherAFI.afi10203sgTitle, OtherAFI.afi10203sgtmTitle, OtherAFI.afi10203sgtTitle, OtherAFI.afi11202v1Title, OtherAFI.afi11202v2Title, OtherAFI.afi11202v3Title, OtherAFI.afi11301v1Title, OtherAFI.afi11301v2Title, OtherAFI.afi11301v4Title, OtherAFI.afi11401Title, OtherAFI.afi11402Title, OtherAFI.afi11403Title, OtherAFI.afi11404Title, OtherAFI.afi11409Title, OtherAFI.afi362101Title, OtherAFI.afi362905Title, OtherAFI.afi362910Title, OtherAFI.afi44103Title, OtherAFI.afi44170Title, OtherAFI.afi44171Title, OtherAFI.afi44172Title, OtherAFI.afi48101Title, OtherAFI.afi48145Title, OtherAFI.afi48149Title, OtherAFI.afi48307v1Title, OtherAFI.afi48307v2Title, OtherAFI.afi48307v3Title, OtherAFI.afi91202Title, OtherAFI.afi91204Title, OtherAFI.afecdTitle, OtherAFI.aetci48102Title, OtherAFI.aetci48103Title, OtherAFI.afman48146Title, OtherAFI.afman48147Title, OtherAFI.afman91223Title, OtherAFI.afocdTitle, OtherAFI.afpam48133Title, OtherAFI.afpd481Title]
    let DocDetailArray:NSArray = [OtherAFI.afi10203sgDetail, OtherAFI.afi10203sgtmDetail, OtherAFI.afi10203sgtDetail, OtherAFI.afi11202v1Detail, OtherAFI.afi11202v2Detail, OtherAFI.afi11202v3Detail, OtherAFI.afi11301v1Detail, OtherAFI.afi11301v2Detail, OtherAFI.afi11301v4Detail, OtherAFI.afi11401Detail, OtherAFI.afi11402Detail, OtherAFI.afi11403Detail, OtherAFI.afi11404Detail, OtherAFI.afi11409Detail, OtherAFI.afi362101Detail, OtherAFI.afi362905Detail, OtherAFI.afi362910Detail, OtherAFI.afi44103Detail, OtherAFI.afi44170Detail, OtherAFI.afi44171Detail, OtherAFI.afi44172Detail, OtherAFI.afi48101Detail, OtherAFI.afi48145Detail, OtherAFI.afi48149Detail, OtherAFI.afi48307v1Detail, OtherAFI.afi48307v2Detail, OtherAFI.afi48307v3Detail, OtherAFI.afi91202Detail, OtherAFI.afi91204Detail, OtherAFI.afecdDetail, OtherAFI.aetci48102Detail, OtherAFI.aetci48103Detail, OtherAFI.afman48146Detail, OtherAFI.afman48147Detail, OtherAFI.afman91223Detail, OtherAFI.afocdDetail, OtherAFI.afpam48133Detail, OtherAFI.afpd481Detail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        global.selection = ""
        global.selection = DocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection == OtherAFI.aetci48102Title {
            global.url = Bundle.main.url(forResource: "AF AETCI 48-102 Medical Management of UFT Students (5 Nov 2013)", withExtension: "pdf")
        } else if global.selection == OtherAFI.aetci48103Title {
            global.url = Bundle.main.url(forResource: "AF AETCI 48-103 Training Health & Human Performance Program (24 Apr 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11202v1Title {
            global.url = Bundle.main.url(forResource: "AFI 11-202v1 Aircrew Training (14 Jun 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11202v2Title {
            global.url = Bundle.main.url(forResource: "AFI 11-202v2 Aircrew Standardization-Evaluation Program (18 Dec 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11202v3Title {
            global.url = Bundle.main.url(forResource: "AFI 11-202v3 General Flight Rules (2 Oct 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11301v1Title {
            global.url = Bundle.main.url(forResource: "AFI 11-301v1 Aircrew Flight Equipment Program (10 Oct 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11301v2Title {
            global.url = Bundle.main.url(forResource: "AFI 11-301v2 Management & Configuration Req for AFE (6 Dec 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11301v4Title {
            global.url = Bundle.main.url(forResource: "AFI 11-301v4 Aircrew Laser Eye Program (17 Feb 2010)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11401Title {
            global.url = Bundle.main.url(forResource: "AFI 11-401 Aviation Management (30 Aug 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11402Title {
            global.url = Bundle.main.url(forResource: "AFI 11-402 Aviation & Parachutist Service Aeronautical Ratings & Aviation Badges (28 Feb 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11403Title {
            global.url = Bundle.main.url(forResource: "AFI 11-403 Aerospace Physiological Training Program (25 Mar 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11404Title {
            global.url = Bundle.main.url(forResource: "AFI 11-404 Fighter Aircrew Acceleration Training Program (9 Jun 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi11409Title {
            global.url = Bundle.main.url(forResource: "AFI 11-409 High Altitude Airdrop Mission Support Program (9 Sep 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi362905Title {
            global.url = Bundle.main.url(forResource: "AFI 36-2905 Fitness Program (27 Aug 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi362910Title {
            global.url = Bundle.main.url(forResource: "AFI 36-2910 LOD Determination, Medical Continuation, & Incapacitation Pay (8 Oct 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi44170Title {
            global.url = Bundle.main.url(forResource: "AFI 44-170 Preventive Health Assessment (19 Jan 2016)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi44172Title {
            global.url = Bundle.main.url(forResource: "AFI 44-172 Mental Health (13 Nov 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48101Title {
            global.url = Bundle.main.url(forResource: "AFI 48-101 Aerospace Medicine Enterprise (8 Dec 2014)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48145Title {
            global.url = Bundle.main.url(forResource: "AFI 48-145 Occupational & Environmental Health Program (11 Jul 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48149Title {
            global.url = Bundle.main.url(forResource: "AFI 48-149 Flight & Operational Medicine Program (18 Dec 2015)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi91202Title {
            global.url = Bundle.main.url(forResource: "AFI 91-202 USAF Mishap Prevention Program (21 May 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi91204Title {
            global.url = Bundle.main.url(forResource: "AFI 91-204 Safety Investigations & Reports (27 Apr 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afman48146Title {
            global.url = Bundle.main.url(forResource: "AFMAN 48-146 Occupational & Environmental Health Program Management (15 Oct 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afman48147Title {
            global.url = Bundle.main.url(forResource: "AFMAN 48-147_IP Tri-Service Food Code (30 Apr 2014)", withExtension: "pdf")
        }else if global.selection == OtherAFI.afman91223Title {
            global.url = Bundle.main.url(forResource: "AFMAN 91-223 Aviation Safety Investigations & Reports (14 Sep 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afpd481Title {
            global.url = Bundle.main.url(forResource: "AFPD 48-1 Aerospace Medicine Enterprise (23 Aug 2011)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afecdTitle {
            global.url = Bundle.main.url(forResource: "AFECD (31 Oct 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afocdTitle {
            global.url = Bundle.main.url(forResource: "AFOCD (31 Oct 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afpam48133Title {
            global.url = Bundle.main.url(forResource: "AFPAM 48-133 Physical Examination Techniques (1 Jun 2000)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi362101Title {
            global.url = Bundle.main.url(forResource: "AFI 36-2101 Classifying Military Personnel (9 Mar 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi44171Title  {
            global.url = Bundle.main.url(forResource: "AFI 44-171 Patient Centered Medical Home Operations (28 Nov 2014)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi44103Title {
            global.url = Bundle.main.url(forResource: "AFI 44-103 Air Force IDMT Program (30 Aug 2018)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi10203sgTitle {
            global.url = Bundle.main.url(forResource: "AFI 10-203 Supplemental Guidance (17 Nov 2016)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi10203sgtTitle {
            global.url = Bundle.main.url(forResource: "AFI 10-203 Supplemental Guidance Profile Timelines (Jun 2014)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi10203sgtmTitle {
            global.url = Bundle.main.url(forResource: "AFI 10-203 Supplemental Guidance Profile Templates (4 Dec 2014)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48307v1Title {
            global.url = Bundle.main.url(forResource: "AFI 48-307v1 En Route Care & Aeromedical Evacuation Medical Operations (9 Jan 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48307v2Title {
            global.url = Bundle.main.url(forResource: "AFI 48-307v2 En Route Critical Care (10 Jan 2017)", withExtension: "pdf")
        } else if global.selection == OtherAFI.afi48307v3Title {
            global.url = Bundle.main.url(forResource: "AFI 48-307v3 En Route Care Documentation (12 Apr 2016)", withExtension: "pdf")
        } else {
            docError()
        }
        global.pdfDocument = PDFDocument(url: global.url!)!
        self.performSegue(withIdentifier: "FromOtherAFIsToPDFSegue", sender: Any?.self)
        
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
