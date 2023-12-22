//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoTitleView())
        getUserImage()
        setupUI()
        setupUIWithDatas()
//        UserDefaults.standard.setValue(nil, forKey: "token")
//        UserDefaults.standard.setValue(nil, forKey: "userID")
//        UserDefaults.standard.setValue(nil, forKey: "isLaunched")
    }
    
    private func getUserImage() {
        let homeTitleView = HomeTitleView()
        homeTitleView.configure(profileImage: nil)
        DispatchQueue.main.async {[weak self] in
            self?.viewModel.userImage(sessionDelegate: self) { url in
                guard let url = url else { return }
                let imageView = UIImageView()
                imageView.download(from: url, sessionDelegate: self) {
                    guard let image = imageView.image else { return }
                    homeTitleView.configure(profileImage: image)
                }
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeTitleView)
    }
    
    private func setupUIWithDatas() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        self.viewModel.topProducts(sessionDelegate: self) { success in
            group.leave()
        }
        
        self.viewModel.categories(sessionDelegate: self) { success in
            group.leave()
        }
        
        self.viewModel.latestProducts(sessionDelegate: self) { success in
            group.leave()
        }
        
        group.notify(queue: .main) {
//            print(self.viewModel.sections)
        }
    }
    
    private func setupUI() {
        
    }
}
