//
//  AirForceOxConvAboutViewController.swift
//  BookReader
//
//  Created by Colby Uptegraft on 6/30/18.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import UIKit

class AirForceOxConvAboutViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var aboutLabelTwo: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "About"
        
        self.aboutLabel.text = "This application uses the equation:"
        
        self.aboutLabelTwo.text = "to calculate the inspiratory oxygen needs of patients flown at various cabin altitudes for the purpose of aeromedical evacuations and provides a recommendation for the method of oxygen delivery.  The margin of error is +/- 1%.  \n\nThe calculated results are recommendations only.  The actual amount of oxygen and delivery method should be based on the clinical status of each individual patient."
        
        
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

