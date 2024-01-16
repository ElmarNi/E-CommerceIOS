//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let spinner = Spinner()
    internal let viewModel = HomeViewModel()
    internal let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider:
                    { sectionIndex, _ in
                        return HomeViewController.configureCollectionViewLayout(sectionIndex: sectionIndex)
                    }
            )
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoTitleView())
        
        view.addSubview(collectionView)
        view.addSubview(spinner)
        
        userImage()
        setupUI()
        setupCollectionView()
        spinner.startAnimating()
        
        viewModel.getCollectionViewData(sessionDelegate: self) {[weak self] in
            self?.collectionView.reloadData()
            self?.spinner.stopAnimating()
        }
//        UserDefaults.standard.setValue(nil, forKey: "token")
//        UserDefaults.standard.setValue(nil, forKey: "userID")
//        UserDefaults.standard.setValue(nil, forKey: "isLaunched")
    }
    
    private func userImage() {
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
    
    private func setupUI() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.height.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalToSuperview().inset(12)
        }
    }
}
