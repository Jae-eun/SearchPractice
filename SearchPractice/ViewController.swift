//
//  ViewController.swift
//  SearchPractice
//
//  Created by 이재은 on 12/06/2019.
//  Copyright © 2019 Jaeeun Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var searchResultTableView: UITableView!
    
    private var wordList = ["rabbit", "dog", "cat", "lion", "tiger",
                            "snake", "horse", "bird", "elephant", "cow",
                            "deer", "sheep", "mouse", "bear", "beaver"]
    private var reuseIdentifier = "WordCell"
    private var filteredList: [String] = []
    private var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
    }

    func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isFiltered {
        case true:
            return filteredList.count
        default:
            return wordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? WordTableViewCell else { return UITableViewCell() }
        
        if isFiltered {
            cell.wordTextLabel.text = filteredList[indexPath.row]
        } else {
            cell.wordTextLabel.text = wordList[indexPath.row]
        }
        
        return cell
    }
    
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let hasText = searchController.searchBar.text?.lowercased() {
            if hasText.isEmpty {
                isFiltered = false
            } else {
                isFiltered = true
                filteredList = wordList.filter({ (element) -> Bool in
                    element.contains(hasText)
                })
            }
            searchResultTableView.reloadData()
        }
    }
    
    
}
