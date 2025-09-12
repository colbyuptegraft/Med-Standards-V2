//  AboutViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2025 Doc Apps LLC - https://www.doc-apps.com
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
        self.TextView.text = """
            This app presents the medical standards for special duty personnel of the United States Air Force, Army, and Navy as well as some other useful tools and information for Aerospace Medicine Professionals. All documents have been cleared for public release.
            
            Med Standards is FREE once again!!!
            
            If you do not see updated content after receiving a notification that new documents are available, please close & re-open the app.
            
            If you experience any bugs, please email info@doc-apps.com. Most bugs can likely be solved by uninstalling and re-installing the app.
            
            Thank you all for your ongoing support and continuous suggestions for content updates and improvements.
            """
        TextView.isEditable = false
        TextView.dataDetectorTypes = UIDataDetectorTypes.all
    }
}
