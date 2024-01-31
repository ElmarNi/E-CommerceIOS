//
//  ProfileViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.12.23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    private let titleView = UIView()
    private let viewModel = HomeViewModel()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        titleView.backgroundColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
        titleView.addSubview(profileImageView)
        navigationController?.navigationBar.isHidden = true
        view.addSubview(titleView)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let statusBarManager = windowScene.statusBarManager {
            let statusBarView = UIView(frame: statusBarManager.statusBarFrame)
            statusBarView.backgroundColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
            view.addSubview(statusBarView)
        }

//        if let userID = UserDefaults.standard.value(forKey: "userID") as? Int {
//            viewModel.userImage(sessionDelegate: self, userID: userID) {[weak self] url in
//                guard let url = url else { return }
//                self?.profileImageView.download(from: url, sessionDelegate: self, completion: {
//                    
//                })
//            }
//        }
        
        setupUI()
    }
    
    private func setupUI(){
        titleView.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(130)
        }
//        profileImageView.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(16)
//            make.height.width.equalTo(40)
//            make.centerY.equalToSuperview()
//        }
    }

}
