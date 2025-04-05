//  SearchViewController.swift
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
import PDFKit

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ searchViewController: SearchViewController, didSelectSearchResult selection: PDFSelection)
    func searchResultDidClear()
}

class SearchViewController: UITableViewController {
    
    // MARK: - Public properties
    
    weak var delegate: SearchViewControllerDelegate?
    var pdfDocument: PDFDocument? {
        didSet {
            pdfDocument?.delegate = self
        }
    }

    // MARK: - Private properties
    
    private var searchBar = UISearchBar()
    private(set) var searchResults = [PDFSelection]()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .setTitleTextAttributes(
                [NSAttributedString.Key(
                    rawValue: NSAttributedString.Key.foregroundColor.rawValue): global.searchViewFontColor],
                for: .normal
            )

        tableView.rowHeight = 88
        tableView.register(UINib(nibName: String(describing: SearchResultsCell.self),
                                 bundle: nil), forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    deinit {
        pdfDocument?.cancelFindString()
        pdfDocument?.delegate = nil
    }
    
    // MARK: - TableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Text"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultsCell

        let selection = searchResults[indexPath.row]

        let extendedSelection = selection.copy() as! PDFSelection
        extendedSelection.extend(atStart: 20)
        extendedSelection.extend(atEnd: 20)

        let outline = pdfDocument?.outlineItem(for: selection)
        cell.section = outline?.label

        let page = selection.pages.first
        cell.page = page?.label

        cell.resultText = extendedSelection.string
        cell.searchText = selection.string

        return cell
    }
    
    // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = searchResults[indexPath.row]
        searchBar.resignFirstResponder()
        delegate?.searchViewController(self, didSelectSearchResult: selection)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pdfDocument?.cancelFindString()
        
        guard let text = searchBar.text else { return }
        
        let searchText = text.trimmingCharacters(in: .whitespaces)
        if searchText.count >= 3 {
            clearResultsOnScreen()
            pdfDocument?.beginFindString(searchText, withOptions: .caseInsensitive)
        } else {
            clearResultsOnScreen()
            delegate?.searchResultDidClear()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    private func clearResultsOnScreen() {
        searchResults.removeAll()
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: PDFDocumentDelegate {
    func didMatchString(_ instance: PDFSelection) {
        searchResults.append(instance)
        tableView.reloadData()
    }
}
