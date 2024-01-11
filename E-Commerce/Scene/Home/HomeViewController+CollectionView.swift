//
//  HomeViewController+CollectionView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 10.01.24.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal static func configureCollectionViewLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        var itemWidth: CGFloat = 1/3
        var groupHeiht: CGFloat = 60
        var scrollType = UICollectionLayoutSectionOrthogonalScrollingBehavior.none
        
        switch sectionIndex {
        case 0:
            itemWidth = 1
            groupHeiht = 148
            scrollType = .paging
        case 1:
            scrollType = .continuous
        case 2:
            itemWidth = 1/2
            groupHeiht = 227
        default: break
        }
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 4)
        
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
    
    internal func setupCollectionView() {
        collectionView.register(TopProductCollectionViewCell.self, forCellWithReuseIdentifier: TopProductCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(TitleView.self, forSupplementaryViewOfKind: "TitleView", withReuseIdentifier: TitleView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .topProducts(let products):
            return products.count
        case .categories(let categories):
            return categories.count
        case .latestProducts(let products):
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case let .topProducts(products):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopProductCollectionViewCell.identifier, for: indexPath) as? TopProductCollectionViewCell else { return UICollectionViewCell()
            }
            cell.configure(product: products[indexPath.row], count: products.count, index: indexPath.row)
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
