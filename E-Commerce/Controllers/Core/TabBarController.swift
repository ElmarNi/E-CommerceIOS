//
//  TabBarController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        viewControllers = [homeNavVC, searchNavVC]
    }

}
