//
//  ProductsViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 12.01.24.
//

import UIKit

class ProductsViewController: UIViewController {

    private let category: String?
    private let spinner = Spinner()
    internal let viewModel = ProductsViewModel()
    internal let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider:
                    { _, _ in
                        return ProductsViewController.configureCollectionViewLayout()
                    }
            )
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(spinner)
        
        setupUI()
        setupCollectionView()
        spinner.startAnimating()
        
        if let category = category {
            viewModel.byCategory(sessionDelegate: self, category: category) {[weak self] isError, errorString in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    self?.collectionView.reloadData()
                }
                self?.spinner.stopAnimating()
            }
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
