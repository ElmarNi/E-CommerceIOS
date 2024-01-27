//
//  ProductDetailViewController+CollectionView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 24.01.24.
//

import Foundation
import UIKit

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal static func configureCollectionViewLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .fractionalHeight(1)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    internal func setupCollectionView() {
        collectionView.register(TopProductCollectionViewCell.self, forCellWithReuseIdentifier: TopProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopProductCollectionViewCell.identifier, for: indexPath) as? TopProductCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.isProductDetail = true
        cell.configure(count: product.images.count, index: indexPath.row, urlString: product.images[indexPath.row])
        return cell
    }
    
}
