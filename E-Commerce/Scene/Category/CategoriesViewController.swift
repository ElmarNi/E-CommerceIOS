//
//  CategoriesViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.12.23.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private let spinner = Spinner()
    internal let viewModel = CategoriesViewModel()
    internal let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider:
                    { _, _ in
                        return CategoriesViewController.configureCollectionViewLayout()
                    }
            )
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Categories"
        
        view.addSubview(collectionView)
        view.addSubview(spinner)
        
        setupUI()
        setupCollectionView()
        spinner.startAnimating()
        viewModel.categories(sessionDelegate: self) {[weak self] isError, errorString in
            isError ? self?.showAlert(title: "Error", message: errorString) : self?.collectionView.reloadData()
            self?.spinner.stopAnimating()
        }
    }
    
    private func setupUI() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        collectionView.snp.makeConstraints { make in
            make.top.height.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalToSuperview().inset(12)
        }
    }
}
