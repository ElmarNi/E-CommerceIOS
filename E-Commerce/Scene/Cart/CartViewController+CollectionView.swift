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
            guard let text = self?.priceLabel.text, 
                  var total = Float(String(text.dropFirst())),
                  let index = self?.viewModel.cart?.products.firstIndex(where: { $0.id == cell.cartProduct?.id })
            else { return }
            
            self?.viewModel.cart?.products[index].quantity = cell.cartProduct?.quantity ?? 0
            self?.viewModel.cart?.products[index].total = cell.cartProduct?.total ?? 0
            
            total += newTotal
            self?.priceLabel.text = "$\(String(total).replacingOccurrences(of: ".0", with: ""))"
        }
        
        cell.deleteButtonOnAction = {[weak self] in
            let alertViewController = UIAlertController(title: nil, message: "Are you sure to delete this product from cart?", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                guard let cartId = self?.viewModel.cart?.id,
                      var products = self?.viewModel.cart?.products
                else {
                    return
                }
                
                let deletedProductTotal = products.first(where: {$0.id == cell.cartProduct?.id})?.total ?? 0
                products.removeAll{ $0.id == cell.cartProduct?.id }
                self?.loadingView.isHidden = false
                self?.viewModel.updateCart(
                    sessionDelegate: self,
                    cartId: cartId,
                    merge: false,
                    products: products,
                    completion:
                        { isError, errorString in
                            if isError {
                                self?.showAlert(title: "Error", message: errorString)
                            }
                            else {
                                self?.viewModel.cart?.products = products
                                self?.collectionView.reloadData()
                                self?.loadingView.isHidden = true
                                self?.checkoutButton.setTitle("Checkout (\(products.count))", for: .normal)
                                guard let text = self?.priceLabel.text, let total = Float(String(text.dropFirst())) else { return }
                                self?.priceLabel.text = "$\(String(total - deletedProductTotal).replacingOccurrences(of: ".0", with: ""))"
                                self?.hideOrDisplay(isEmpty: self?.viewModel.cart?.products.count == 0)
                                
                                if self?.viewModel.cart?.products.count == 0 {
                                    self?.hideOrDisplay(isEmpty: self?.viewModel.cart?.products.count == 0)
                                }
                            }
                        }
                )
                
            }))
            alertViewController.addAction(UIAlertAction(title: "No", style: .default))
            self?.present(alertViewController, animated: true)
        }
        return cell
    }
    
}
