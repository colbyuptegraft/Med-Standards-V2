//  OutlineCell.swift
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

class OutlineCell: UITableViewCell {
    var label: String? = nil {
        didSet {
            titleLabel.text = label
        }
    }
    var pageLabel: String? = nil {
        didSet {
            pageNumberLabel.text = pageLabel
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pageNumberLabel: UILabel!
    @IBOutlet private weak var indentationConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        pageNumberLabel.textColor = .gray
        pageNumberLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }

    override func updateConstraints() {
        super.updateConstraints()
        indentationConstraint.constant = CGFloat(15 + 10 * indentationLevel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if indentationLevel == 0 {
            titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        } else {
            titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        }

        separatorInset = UIEdgeInsets(top: 0, left: safeAreaInsets.right + indentationConstraint.constant, bottom: 0, right: 0)
    }
}
