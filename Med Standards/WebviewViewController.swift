//  WebviewViewController.swift
//  Med Standards
//
//  The MIT License
//
//  Copyright (c) 2015 - 2020 Colby Uptegraft - https://www.colbycoapps.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  The Software is provided “As Is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.  In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the Software or the use of there dealings in the Software.
//
//  This license does not extend to any of the Portable Document Format (PDF) files included with the Software.  These PDF files may not be used, copied, modified, published, distributed, sublicense, and/or sold without the express permission of the United States Department of Defense.

import UIKit
import WebKit

class WebviewViewController: UIViewController {
    
    @IBOutlet var Webview:WKWebView!
    
    var docController: UIDocumentInteractionController?
    let downloadIcon:UIImage = UIImage(named: "download.png")!
    let redoIcon:UIImage = UIImage(named: "redo.png")!
    let backArrow:UIImage = UIImage(named: "backArrow.png")!
    let forwardArrow:UIImage = UIImage(named: "forwardArrow.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if global.webUrl == global.pracGuideLink {
            self.navigationController?.navigationBar.barTintColor = global.airForceColor
            self.tabBarController?.tabBar.barTintColor = global.airForceColor
        } else {
            self.navigationController?.navigationBar.barTintColor = global.navyColor
            self.tabBarController?.tabBar.barTintColor = global.navyColor
        }
        
        let reloadButton = UIBarButtonItem(image: redoIcon, style: .plain, target: self, action: #selector(WebviewViewController.webViewLoad))
        let backButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(WebviewViewController.goBack))
        let forwardButton = UIBarButtonItem(image: forwardArrow, style: .plain, target: self, action: #selector(WebviewViewController.goForward))
        self.navigationItem.setRightBarButtonItems([forwardButton, backButton, reloadButton], animated: false)
        
        if #available(iOS 13.0, *) {
            Webview.scalesLargeContentImage = true
        } else {
            // Fallback on earlier versions
        }
        Webview.isMultipleTouchEnabled = true
        webViewLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if global.webUrl == global.pracGuideLink {
            self.navigationController?.navigationBar.barTintColor = global.airForceColor
            self.tabBarController?.tabBar.barTintColor = global.airForceColor
        } else {
            self.navigationController?.navigationBar.barTintColor = global.navyColor
            self.tabBarController?.tabBar.barTintColor = global.navyColor
        }
    }
    
    @objc func webViewLoad() {
        if global.webUrl == global.pracGuideLink {
            self.title = global.pracGuideTitle
        } else {
            self.title = global.navyWikiTitle
        }
        let url = global.webUrl
        let requestUrl = URL(string: url)
        let request = URLRequest(url: requestUrl!)
        Webview?.load(request)
    }
    
    @objc func goBack() {
        Webview.goBack()
    }
    
    @objc func goForward(){
        Webview.goForward()
    }
}
