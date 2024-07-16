//
//  DownloadViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//
import Foundation
import UIKit
private let reuseIdentifier = "DownloadCell"
class DownloadViewController:UITableViewController{
    //MARK: - Properties
    private var episodeResult = UserDefaults.downloadEpisodeRead()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setNotificationCenter()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.episodeResult = UserDefaults.downloadEpisodeRead()
        tableView.reloadData()
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController  = window.keyWindow?.rootViewController as! MainTabbarController
        mainTabController.viewControllers?[2].tabBarItem.badgeValue = nil
    }
    
}
//MARK: - Helpers
extension DownloadViewController{
   
}
extension DownloadViewController{
    private func setup(){
        view.backgroundColor = .white
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    private func setNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownload), name: .downloadNotificationName, object: nil)
    }
}
//MARK: - Selectors
extension DownloadViewController{
    @objc private func handleDownload(notification:Notification){
        guard let response = notification.userInfo as? [String:Any] else { return }
        guard let title = response["title"] as? String else { return  }
        guard let progressValue = response["progress"] as? Double else { return  }
        guard let index = self.episodeResult.firstIndex(where: {$0.title == title}) else {return}
        guard let cell = self.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? EpisodeCell else {return}
        cell.progressView.isHidden = false
        cell.progressView.setProgress(Float(progressValue), animated: true)
        if progressValue >= 1{
            cell.progressView.isHidden = true
        }
    }
}
//MARK: - UITableViewDataSource
extension DownloadViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        cell.episode = episodeResult[indexPath.row]
        return cell
    }
}
//MARK: - UITableViewDelegate
extension DownloadViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PlayerViewController(episode: episodeResult[indexPath.row])
        self.present(controller, animated: true)
    }
}
