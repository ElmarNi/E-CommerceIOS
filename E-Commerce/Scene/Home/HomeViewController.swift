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
    private let viewModel = HomeViewModel()
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider:
                    { sectionIndex, _ in
                        return HomeViewController.configureCollectionViewLayout(sectionIndex: sectionIndex)
                    }
            )
        )
        collectionView.register(TopProductCollectionViewCell.self, forCellWithReuseIdentifier: TopProductCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(TitleView.self, forSupplementaryViewOfKind: "TitleView", withReuseIdentifier: TitleView.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
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
        setupUIWithDatas()
        collectionView.delegate = self
        collectionView.dataSource = self
        spinner.startAnimating()
//        
//        UserDefaults.standard.setValue(nil, forKey: "token")
//        UserDefaults.standard.setValue(nil, forKey: "userID")
//        UserDefaults.standard.setValue(nil, forKey: "isLaunched")
    }
    
    private static func configureCollectionViewLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        var itemWidth: CGFloat = 1/3
        var groupHeiht: CGFloat = 60
        var scrollType = UICollectionLayoutSectionOrthogonalScrollingBehavior.none
        
        switch sectionIndex {
        case 0:
            itemWidth = 1
            groupHeiht = 148
        case 1:
            scrollType = .continuous
        case 2:
            itemWidth = 1/2
            groupHeiht = 227
        default: break
        }
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth),
                                                                             heightDimension: .fractionalHeight(1)))
        
        if sectionIndex != 0 {
            item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 4)
        }
        else {
            item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)
        }
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(groupHeiht)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollType
        if sectionIndex != 0 {
            let titleView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(40)),
                elementKind: "TitleView",
                alignment: .top)
            
            titleView.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            section.boundarySupplementaryItems = [titleView]
        }
        return section
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
    
    private func setupUIWithDatas() {
        let group = DispatchGroup()
        var categories = [String]()
        var latestProducts = [Product]()
        var topProducts = [Product]()
        group.enter()
        group.enter()
        group.enter()
        
        self.viewModel.topProducts(sessionDelegate: self) { result in
            if let result = result {
                topProducts = result
            }
            group.leave()
        }
        
        self.viewModel.categories(sessionDelegate: self) { result in
            if let result = result {
                categories = result
            }
            group.leave()
        }
        
        self.viewModel.latestProducts(sessionDelegate: self) { result in
            if let result = result {
                latestProducts = result
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.viewModel.sections.append(.topProducts(data: topProducts))
            self?.viewModel.sections.append(.categories(data: categories))
            self?.viewModel.sections.append(.latestProducts(data: latestProducts))
            self?.collectionView.reloadData()
            self?.spinner.stopAnimating()
        }
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .topProducts(data: _):
            return 1
        case .categories(let categories):
            return categories.count
        case .latestProducts(let products):
            return products.count
        }
    }
    
    func collectionView(_ collectioX5nView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case let .topProducts(products):
            guard let cell = collectioX5nView.dequeueReusableCell(withReuseIdentifier: TopProductCollectionViewCell.identifier, for: indexPath) as? TopProductCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(products)
            return cell
        case let .categories(categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell()
            }
            cell.configure(category: categories[indexPath.row])
            return cell
        case let .latestProducts(products):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()
            }
            cell.configure(product: products[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "TitleView",
           let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleView.identifier, for: indexPath) as? TitleView
        {
            view.configure(title: viewModel.sections[indexPath.section].title, sectionIndex: indexPath.section)
            return view
        }
        return UICollectionReusableView()
    }
    
}
