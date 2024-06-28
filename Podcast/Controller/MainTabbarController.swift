//
//  ViewController.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import UIKit

class MainTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: - Helpers
extension MainTabbarController{
    private func setup(){
        viewControllers = [
            createViewController(FavoriteViewController(), "Favorite", "play.circle.fill"),
            createViewController(SearchViewController(), "Search", "magnifyingglass.circle.fill"),
            createViewController(DownloadViewController(), "Download", "square.stack.fill")
        ]
    }
    private func createViewController(_ rootViewController:UIViewController,_ title:String,_ imageName:String)->UINavigationController{
        
        rootViewController.title = title
        let controller = UINavigationController(rootViewController: rootViewController)
        let appearence = UINavigationBarAppearance()
        appearence.configureWithDefaultBackground()
        
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.standardAppearance = appearence
        controller.navigationBar.scrollEdgeAppearance = appearence
        controller.navigationBar.compactScrollEdgeAppearance = appearence
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)

        return controller
    }
}
