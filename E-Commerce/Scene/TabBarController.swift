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
        UITabBar.appearance().tintColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        
        let homeVC = HomeViewController()
        let categoriesVC = CategoriesViewController()
        let cartVC = CartViewController()
        let profileVC = ProfileViewController()
        let wishlistVC = WishlistViewController()
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let categoriesNavVC = UINavigationController(rootViewController: categoriesVC)
        let cartNavVC = UINavigationController(rootViewController: cartVC)
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        let wishlistNavVC = UINavigationController(rootViewController: wishlistVC)
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home-inactive"), selectedImage: UIImage(named: "home-active"))
        
        categoriesNavVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(named: "categories-inactive"), selectedImage: UIImage(named: "categories-active"))
        cartNavVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart-inactive"), selectedImage: UIImage(named: "cart-active"))
        profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-inactive"), selectedImage: UIImage(named: "profile-active"))
        wishlistNavVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(named: "wishlist-inactive"), selectedImage: UIImage(named: "wishlist-active"))
        
        viewControllers = [homeNavVC, categoriesNavVC, cartNavVC, wishlistNavVC,profileNavVC]
    }

}
