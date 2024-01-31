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
    private let searchView = SearchView()
    private let homeTitleView = HomeTitleView()
    private let isSearchActive = false
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
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoTitleView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeTitleView)
        
        view.addSubview(collectionView)
        view.addSubview(spinner)
        view.addSubview(searchView)
        
        userImage()
        setupUI()
        setupCollectionView()
        spinner.startAnimating()
        
        
        viewModel.getCollectionViewData(sessionDelegate: self) {[weak self] in
            self?.collectionView.reloadData()
            self?.spinner.stopAnimating()
        }
        
        searchView.onAction = {[weak self] text in
            let productsViewController = ProductsViewController(query: text)
            self?.navigationController?.pushViewController(productsViewController, animated: true)
        }
        
        homeTitleView.searchButtonOnAction = {[weak self] position in
            self?.searchView.toggleShow()
        }
        homeTitleView.profileButtonOnAction = {[weak self] in
            self?.navigationController?.tabBarController?.selectedIndex = 4
        }
//        
//        UserDefaults.standard.setValue(nil, forKey: "token")
//        UserDefaults.standard.setValue(nil, forKey: "userID")
//        UserDefaults.standard.setValue(nil, forKey: "isLaunched")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.homeTitleView.changeSearchButtonImage(hide: true)
        self.searchView.toggleShow(hide: true)
    }
    
    private func userImage() {
        if let userID = UserDefaults.standard.value(forKey: "userID") as? Int {
            viewModel.userImage(sessionDelegate: self, userID: userID) {[weak self] url in
                guard let url = url else { return }
                let imageView = UIImageView()
                imageView.download(from: url, sessionDelegate: self) { [weak self] in
                    guard let image = imageView.image else { return }
                    self?.homeTitleView.configure(profileImage: image)
                }
            }
        }
        else {
            homeTitleView.configure(profileImage: nil)
        }
    }
    
    private func setupUI() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        collectionView.snp.makeConstraints { make in
            make.top.height.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalToSuperview().inset(12)
        }
        searchView.snp.makeConstraints { 
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.width.equalToSuperview()
        }
        homeTitleView.snp.makeConstraints { $0.width.equalTo(100) }
    }
}
