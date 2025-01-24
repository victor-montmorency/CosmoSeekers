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
    }
    
    private func setupTabs(){
        let home = self.createNav(title: "Home", image: UIImage(systemName: "house"), vc: HomeViewController())
        let dailyPicture = self.createNav(title: "Image Of the Day", image: UIImage(systemName: "photo.fill"), vc: DailyPictureViewController())
        self.setViewControllers( [home, dailyPicture], animated: true)
    }

    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}

