//
//  ProductsViewController+CollectionView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 16.01.24.
//

import Foundation
import UIKit

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal static func configureCollectionViewLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 4, bottom: 6, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(203)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    internal func setupCollectionView() {
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()
        }
        cell.configure(product: viewModel.getProduct(index: indexPath.row))
        return cell
    }
    
}
