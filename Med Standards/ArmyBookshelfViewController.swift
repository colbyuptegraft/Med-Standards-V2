//
//  ArmyBookshelfViewController.swift
//  BookReader
//
//  Created by Colby Uptegraft on 6/30/18.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import PDFKit

struct Army {
    
    static let ar40501Title = "AR 40-501"
    static let ar40501Detail = "Standards of Medical Fitness (14 Jun 2017)"
    
    static let fSChecklistTitle = "FS Checklist"
    static let fSChecklistDetail = "Aeromedical Policy Letters & Technical Bulletins (May 2015)"
    
    static let petableTitle = "PE Requirements Table"
    static let petableDetail = "Army Physical Exam Requirements Table (12 Nov 2002)"
    
}

class ArmyBookshelfViewController: UITableViewController {
    
    let DocArray:NSArray = [Army.ar40501Title, Army.fSChecklistTitle, Army.petableTitle]
    let DocDetailArray:NSArray = [Army.ar40501Detail, Army.fSChecklistDetail, Army.petableDetail]
    
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
        global.selection = DocArray[(indexPath as NSIndexPath).row] as! String
        
        if global.selection == Army.ar40501Title {
            global.url = Bundle.main.url(forResource: "AR 40-501 Standards of Medical Fitness (14 Jun 2017)", withExtension: "pdf")
        } else if global.selection == Army.fSChecklistTitle {
            global.url = Bundle.main.url(forResource: "Army FS Checklist (May 2015)", withExtension: "pdf")
        } else if global.selection == Army.petableTitle {
            global.url = Bundle.main.url(forResource: "Army Physical Exam Table (12 Nov 2002)", withExtension: "pdf")
        } else {
            docError()
        }
        global.pdfDocument = PDFDocument(url: global.url!)!
        self.performSegue(withIdentifier: "FromArmyToPDFSegue", sender: Any?.self)
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
