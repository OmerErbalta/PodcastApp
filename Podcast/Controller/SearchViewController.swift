//
//  SearchViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import Foundation
import UIKit
import Alamofire
private let reuseIdentifier = "SearchCell"
class SearchViewController:UITableViewController{
    //MARK: - Properties
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
}
//MARK: - Helpers

extension SearchViewController{
    private func style(){
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier )
        tableView.rowHeight = 130
        
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    private func layout(){
        
    }
}
//MARK: - TableViewDataSource
extension SearchViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        return cell
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        AF.request(" https://itunes.apple.com/search?term=jack+johnson.").responseData { response in
            print(response.data)
        }
    }
}
