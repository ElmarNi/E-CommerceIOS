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
        configureAppearance()
        configureViewControllers()
    }
    
    private func configureAppearance() {
        UITabBar.appearance().tintColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        UIBarButtonItem.appearance().tintColor = .black
    }
    
    private func configureViewControllers() {
        let homeVC = HomeViewController()
        let categoriesVC = CategoriesViewController()
        let cartVC = CartViewController()
        let profileVC = ProfileViewController()
        
        let homeNavVC = createNavigationController(rootViewController: homeVC, title: "Home", imageName: .home)
        let categoriesNavVC = createNavigationController(rootViewController: categoriesVC, title: "Categories", imageName: .categories)
        let cartNavVC = createNavigationController(rootViewController: cartVC, title: "Cart", imageName: .cart)
        let profileNavVC = createNavigationController(rootViewController: profileVC, title: "Profile", imageName: .profile)
        
        viewControllers = [homeNavVC, categoriesNavVC, cartNavVC, profileNavVC]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, imageName: ImageName) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title, image: imageName.tabBarItemImage, selectedImage: imageName.tabBarSelectedImage)
        return navController
    }
    
    private enum ImageName: String {
        case home
        case categories
        case cart
        case profile
        
        var tabBarItemImage: UIImage? {
            return UIImage(named: rawValue + "-inactive")
        }
        
        var tabBarSelectedImage: UIImage? {
            return UIImage(named: rawValue + "-active")
        }
    }
}
