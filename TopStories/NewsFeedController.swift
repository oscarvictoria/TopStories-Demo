//
//  ViewController.swift
//  TopStories
//
//  Created by Oscar Victoria Gonzalez  on 11/25/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

enum SearchScope {
    case title // title of the headline
    case abstract // a summary of the headline
}

class NewsFeedController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.title // default value is 0 "title"
    
    // TODO: create a variable called searchQuery that calls filter method.
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased())}
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased())}
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }
    
    func filterHeadlines(for searchText: String) {
        // return here simply does nothing, just exits the method
        guard !searchText.isEmpty else { return }
        headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsDVC = segue.destination as? NewsDetailController,
            let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name in the identity inspector")
        }
        let headline = headlines[indexPath.row]
        newsDVC.newsHeadline = headline
    }

}

extension NewsFeedController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headlines.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else {
            fatalError("err, err")
        }
        
        let headline = headlines[indexPath.row]
        
        cell.configured(for: headline)
        
        
        return cell
    }
}

extension NewsFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension NewsFeedController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss the keyboard:
        
        searchBar.resignFirstResponder()
       // filter our data for the table view
        guard let searchText = searchBar.text else {
            //TODO:
            return
        }
        filterHeadlines(for: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
       }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .title
        case 1:
            currentScope = .abstract
           default:
           print("not a valid search scope")
        }
    }
}
