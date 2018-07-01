//
//  WebviewViewController.swift
//  BookReader
//
//  Created by Colby Uptegraft on 6/30/18.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

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
