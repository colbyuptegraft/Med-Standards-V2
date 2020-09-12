//  ActionMenuViewController.swift
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

class ActionMenuViewController: UITableViewController {
    weak var delegate: ActionMenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.separatorInset = .zero
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegate?.actionMenuViewControllerShareDocument(self)
        } else if indexPath.row == 1 {
            delegate?.actionMenuViewControllerPrintDocument(self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol ActionMenuViewControllerDelegate: class {
    func actionMenuViewControllerShareDocument(_ actionMenuViewController: ActionMenuViewController)
    func actionMenuViewControllerPrintDocument(_ actionMenuViewController: ActionMenuViewController)
}
