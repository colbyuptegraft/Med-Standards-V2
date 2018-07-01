//
//  AboutViewController.swift
//  BookReader
//
//  Created by Colby Uptegraft on 7/1/18.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import UIKit

class AboutViewContoller: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TextView.text = "This application presents the medical standards for special duty personnel of the United States Air Force, Army, and Navy as well as other useful tools and information for Aerospace Medicine professionals. \n\nAll AFIs, ARs, and Navy documents were screened and approved for inclusion in this application by Air Force Public Affairs. \n\nUpdates with new document versions will occur once per month.  For questions, concerns, and/or suggestions, please email Colby at colbycoapps@gmail.com."
        
       // self.TextView.sizeToFit()
        TextView.isEditable = false
        TextView.dataDetectorTypes = UIDataDetectorTypes.all
        
    }
 
}
