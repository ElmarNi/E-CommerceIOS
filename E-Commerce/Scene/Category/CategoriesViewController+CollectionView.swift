//
//  CategoriesViewController+CollectionView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 11.01.24.
//

import Foundation
import UIKit

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    internal static func configureCollectionViewLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(60)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    internal func setupCollectionView() {
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(category: viewModel.getCategory(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = viewModel.getCategory(index: indexPath.row)
        let productsViewController = ProductsViewController(category: category)
        productsViewController.title = category
        navigationController?.pushViewController(productsViewController, animated: true)
    }
}
