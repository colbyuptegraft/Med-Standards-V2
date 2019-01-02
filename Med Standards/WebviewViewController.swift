//  WebviewViewController.swift
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

class WebviewViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var Webview: UIWebView!
    
    var docController: UIDocumentInteractionController?
    let downloadIcon:UIImage = UIImage(named: "download.png")!
    let redoIcon:UIImage = UIImage(named: "redo.png")!
    let backArrow:UIImage = UIImage(named: "backArrow.png")!
    let forwardArrow:UIImage = UIImage(named: "forwardArrow.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reloadButton = UIBarButtonItem(image: redoIcon, style: .plain, target: self, action: #selector(WebviewViewController.webViewLoad))
        let backButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(WebviewViewController.goBack))
        let forwardButton = UIBarButtonItem(image: forwardArrow, style: .plain, target: self, action: #selector(WebviewViewController.goForward))
        
        self.navigationItem.setRightBarButtonItems([forwardButton, backButton, reloadButton], animated: false)
        
        Webview.scalesPageToFit = true
        Webview.isMultipleTouchEnabled = true
        
        webViewLoad()
    }
    
    @objc func webViewLoad() {
        if global.selection == FSTlkt.pracGuidTitle {
            self.title = FSTlkt.pracGuidTitle
            let url = "http://www.asams.org/guidelines.htm"
            let requestUrl = URL(string: url)
            let request = URLRequest(url: requestUrl!)
            Webview?.loadRequest(request)
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
    
    @objc func goBack() {
        Webview.goBack()
    }
    
    @objc func goForward(){
        Webview.goForward()
    }
}
