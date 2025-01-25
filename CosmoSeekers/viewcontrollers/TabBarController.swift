//
//  ViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 24/01/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
    }
    
    private func setupTabs(){
        
        
        let home = self.createNav(title: "Home", image: UIImage(systemName: "house"), vc: HomeViewController())
        let dailyPicture = self.createNav(title: "Image Of the Day", image: UIImage(systemName: "photo"), vc: DailyPictureViewController())
        let exoplanets = self.createNav(title: "Exoplanets", image: UIImage(systemName: "globe.americas"), vc: ExoplanetsViewController())
        self.setViewControllers( [home,exoplanets, dailyPicture], animated: true)
    }

    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()

        appearance.backgroundColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

