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
    var searchResult:[Podcast] = []{
        didSet{tableView.reloadData()}
    }
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
        return searchResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.result = self.searchResult[indexPath.row]
        return cell
    }
}
//MARK: - UITableViewDelegate
extension SearchViewController{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Start Searching All Start..."
        label.textAlignment = .center
        label.textColor = .purple 
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchResult.count == 0 ? 80 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = searchResult[indexPath.row]
        let controller = EpisodeViewController(podcast:podcast)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - UISearchBarDelegate
extension SearchViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchService.fetchData(searchText) { result in
            self.searchResult = result
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchResult = []
    }
}
