//
//  EpisodeViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 9.07.2024.
//

import Foundation
import UIKit
private let reuseIdentifier = "EpsiodeCell"
class EpisodeViewController:UITableViewController{
    //MARK: - Properties
    private var podcast:Podcast
    private var episodeReslut:[Episode] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    var isFavorite = false{
        didSet{
            setupNavBarItem()
        }
    }
    private var resultCoreDataItems:[PodcastCoreData]=[]{
        didSet{
            let isValue = resultCoreDataItems.contains(where: {$0.feedUrl == self.podcast.feedUrl})
            if isValue{
                isFavorite = true
            }else{
                isFavorite = false
            }
        }
    }
    //MARK: - LyfeCycle
    init(podcast:Podcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
    
}
//MARK: -Service
extension EpisodeViewController{
    fileprivate func fetchData(){
        EpisoodeService.fetchData(self.podcast.feedUrl!) { result in
            DispatchQueue.main.async{
                self.episodeReslut = result
            }
        }
    }
}
//MARK: - Selectors
extension EpisodeViewController{
    @objc private func handleFavoriteButton(){
        if isFavorite{
            deleteCoreData()
        }else{
            addCoreData()
        }
    }
}
//MARK: -Helpers
extension EpisodeViewController{
    private func deleteCoreData(){
        CoreDataController.deleteCoreData(array: resultCoreDataItems, podcast: self.podcast)
        self.isFavorite = false
    }
    private func addCoreData(){
        let model = PodcastCoreData(context: context)
        CoreDataController.addCoreData(model: model, podcast: self.podcast)
        isFavorite = true
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabbarController
        mainTabController.viewControllers?[0].tabBarItem.badgeValue = "New"
    }
    private func fetchCoreData(){
        let fetchRequest = PodcastCoreData.fetchRequest()
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { result in
            self.resultCoreDataItems = result
        }
    }
    private func setupNavBarItem(){
        if isFavorite{
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(.systemPink,renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = favoriteButton
        }
        else{
            let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart")?.withTintColor(.systemPink,renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = favoriteButton
            
        }
      
    }
    private func setup(){
        self.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
       setupNavBarItem()
        fetchCoreData()
    }
    
}

//MARK: - UITableViewDataSource
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeReslut.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        cell.episode = self.episodeReslut[indexPath.row]
        return cell
    }
}
//MARK: -UITableViewDelegate
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodeReslut[indexPath.row]
        let controller = PlayerViewController(episode: episode)
        self.present(controller,animated: true)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let downloadAction = UIContextualAction(style: .destructive, title: "Download") { action, view, completion in
            print("\(self.episodeReslut[indexPath.row].title)")
            UserDefaults.downloadEpisodeWrite(episode: self.episodeReslut[indexPath.row])
            EpisoodeService.downloadEpisode(episode: self.episodeReslut[indexPath.row])
            let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
            let mainTabController  = window.keyWindow?.rootViewController as! MainTabbarController
            mainTabController.viewControllers?[2].tabBarItem.badgeValue = "New"
            completion(true)
            print(UserDefaults.downloadEpisodeRead())
        }
        let configuration = UISwipeActionsConfiguration(actions: [downloadAction])
        return configuration
    }
}
