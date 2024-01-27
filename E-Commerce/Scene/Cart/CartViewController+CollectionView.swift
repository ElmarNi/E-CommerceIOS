//
//  CartViewController+CollectionView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import Foundation
import UIKit

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal static func configureCollectionViewLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(136)),
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    internal func setupCollectionView() {
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cart?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as? CartCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(cartProduct: viewModel.cart?.products[indexPath.row])
        cell.priceChangeOnAction = {[weak self] newTotal in
            guard let text = self?.priceLabel.text, var total = Float(String(text.dropFirst())) else { return }
            total += newTotal
            self?.priceLabel.text = "$\(String(total).replacingOccurrences(of: ".0", with: ""))"
        }
        return cell
    }
    
}
