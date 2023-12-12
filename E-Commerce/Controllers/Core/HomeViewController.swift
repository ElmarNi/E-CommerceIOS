//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoTitleView())
        getUserImage()
        setupUI()
    }
    
    private func getUserImage() {
        var userID = UserDefaults.standard.value(forKey: "userID") as? Int ?? -1
        let homeTitleView = HomeTitleView()
        homeTitleView.configure(profileImage: nil)
        if userID != -1 {
            DispatchQueue.main.async {
                ApiCaller.shared.getUser(sessionDelegate: self, userId: userID) {[weak self] result in
                    switch result {
                    case .success(let user):
                        let imageView = UIImageView()
                        guard let url = URL(string: user.image),
                              let self = self
                        else { return }
                        
                        imageView.download(from: url, sessionDelegate: self) {
                            guard let image = imageView.image else { return }
                            homeTitleView.configure(profileImage: image)
                        }
                    case .failure(_): break
                    }
                }
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeTitleView)
    }
    
    private func setupUI() {
        
    }
}
