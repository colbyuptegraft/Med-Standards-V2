//  AirForceOxConvAboutViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2019 Colby Uptegraft - https://www.colbycoapps.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  The Software is provided “As Is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.  In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the Software or the use of there dealings in the Software.
//
//  This license does not extend to any of the Portable Document Format (PDF) files included with the Software.  These PDF files may not be used, copied, modified, published, distributed, sublicense, and/or sold without the express permission of the United States Department of Defense.

import UIKit

class AirForceOxConvAboutViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"
        self.aboutLabel.text = "This application uses the equation:"
        self.textView.text = "to calculate the inspiratory oxygen needs of patients flown at various cabin altitudes for the purpose of aeromedical evacuations and provides a recommendation for the method of oxygen delivery.  The margin of error is +/- 1%.  \n\nThe calculated results are recommendations only.  The actual amount of oxygen and delivery method should be based on the clinical status of each individual patient."
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let scrollHeight = screenHeight * 1.5
        self.scrollView.isUserInteractionEnabled = true
        self.scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight)
        self.scrollView.showsVerticalScrollIndicator = true
    }
}

