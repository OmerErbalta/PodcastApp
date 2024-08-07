//
//  FavoriteViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import Foundation
import UIKit
private let reuseIdentifier = "FavoriteCell"
class FavoriteViewController:UICollectionViewController{
    //MARK: - Properties

    private var reslutCoreDataItems:[PodcastCoreData] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    //MARK: - LifeCycle
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabbarController
        mainTabController.viewControllers?[0].tabBarItem.badgeValue = nil
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - Helpers

extension FavoriteViewController{
    private func fetchData(){
        let fetchRequest = PodcastCoreData.fetchRequest()
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { result in
            self.reslutCoreDataItems = result
        }
    }
    private func setup(){
        view.backgroundColor = .white
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
//MARK: - UICollectionViewDataSource
extension FavoriteViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reslutCoreDataItems.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.podcastCoreData = self.reslutCoreDataItems[indexPath.row]
        return cell
    }
    
}
//MARK: - UICOllettionViewDelegate
extension FavoriteViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcastCoreData = self.reslutCoreDataItems[indexPath.row]
        let podcast = Podcast(trackName: podcastCoreData.trackName,artistName: podcastCoreData.artistName,artworkUrl600: podcastCoreData.artworkUrl600,feedUrl: podcastCoreData.feedUrl)
        let controller = EpisodeViewController(podcast: podcast)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30)/2
        return .init(width: width, height: width + 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
