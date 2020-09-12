//  OutlineViewController.swift
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
import PDFKit

class OutlineViewController: UITableViewController {
    var pdfDocument: PDFDocument?
    var toc = [PDFOutline]()
    weak var delegate: OutlineViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.pdfDocument = global.pdfDocument

        if let root = pdfDocument?.outlineRoot {
            var stack = [root]
            while !stack.isEmpty {
                let current = stack.removeLast()
                if let label = current.label, !label.isEmpty {
                    toc.append(current)
                }
                for i in (0..<current.numberOfChildren).reversed() {
                    stack.append(current.child(at: i)!)
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toc.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OutlineCell
        let outline = toc[indexPath.row]

        cell.label = outline.label
        cell.pageLabel = outline.destination?.page?.label

        var indentationLevel = -1
        var parent = outline.parent
        while let _ = parent {
            indentationLevel += 1
            parent = parent?.parent
        }
        cell.indentationLevel = indentationLevel

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outline = toc[indexPath.row]
        if let destination = outline.destination {
            delegate?.outlineViewController(self, didSelectOutlineAt: destination)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol OutlineViewControllerDelegate: class {
    func outlineViewController(_ outlineViewController: OutlineViewController, didSelectOutlineAt destination: PDFDestination)
}
