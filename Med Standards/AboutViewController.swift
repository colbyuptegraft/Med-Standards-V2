//  AboutViewController.swift
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

class AboutViewContoller: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var TextView: UITextView!
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TextView.text = "This application presents the medical standards for special duty personnel of the United States Air Force, Army, and Navy as well as other useful tools and information for Aerospace Medicine professionals. \n\nAll AFIs, ARs, and Navy documents were screened and approved for inclusion in this application by Air Force Public Affairs. \n\nUpdates with new document versions will occur once per month.  For questions, concerns, and/or suggestions, please email info@doc-apps.com."
        TextView.isEditable = false
        TextView.dataDetectorTypes = UIDataDetectorTypes.all
        self.navigationController?.navigationBar.barTintColor = global.aboutColor
        self.tabBarController?.tabBar.barTintColor = global.aboutColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor = global.aboutColor
    }
}
