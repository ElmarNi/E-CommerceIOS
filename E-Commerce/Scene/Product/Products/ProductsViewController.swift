//
//  ProductsViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 12.01.24.
//

import UIKit
import Popover

class ProductsViewController: UIViewController {

    private let category: String?
    private let query: String?
    private let isLatestProducts: Bool?
    private let spinner = Spinner()
    private let searchView = SearchView()
    private let filterView = FilterView()
    private let popover = Popover()
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tag = 0
        return button
    }()
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
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
    
    init(category: String? = nil, query: String? = nil, isLatestProducts: Bool? = nil) {
        self.category = category
        self.query = query
        self.isLatestProducts = isLatestProducts
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
        view.addSubview(searchView)
        filterView.frame = CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: 368)
        
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
        
        if let query = query {
            viewModel.byQuery(sessionDelegate: self, query: query) {[weak self] isError, errorString in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    self?.collectionView.reloadData()
                }
                self?.spinner.stopAnimating()
            }
        }
        
        if isLatestProducts != nil {
            viewModel.latestProducts(sessionDelegate: self) {[weak self] isError, errorString in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    self?.collectionView.reloadData()
                }
                self?.spinner.stopAnimating()
            }
        }
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterButton), UIBarButtonItem(customView: searchButton)]
        
        searchView.onAction = {[weak self] text in
            let productsViewController = ProductsViewController(query: text)
            self?.navigationController?.pushViewController(productsViewController, animated: true)
        }
        
        filterView.onAction = {[weak self] index in
            self?.spinner.startAnimating()
            self?.spinner.isHidden = false
            self?.collectionView.isHidden = true
            self?.popover.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.viewModel.filterProducts(Filter(rawValue: index), completion: {
                    self?.collectionView.reloadData()
                    self?.spinner.stopAnimating()
                    self?.collectionView.isHidden = false
                })
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        toggleSearch(hide: true)
    }
    
    @objc private func searchButtonTapped(_ sender: UIButton) {
        toggleSearch()
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        let originPoint = CGPoint(x: view.frame.width, y: view.safeAreaInsets.top)
        popover.show(filterView, point: originPoint)
    }
    
    private func toggleSearch(hide: Bool = false) {
        searchButton.tag = searchButton.tag == 0 && !hide ? 1 : 0
        searchButton.setImage(UIImage(named: searchButton.tag == 0 ? "search" : "close"), for: .normal)
        navigationItem.rightBarButtonItems = searchButton.tag == 0 ? [UIBarButtonItem(customView: filterButton), UIBarButtonItem(customView: searchButton)] :
                                                               [UIBarButtonItem(customView: searchButton)]
        self.searchView.toggleShow(hide: hide)
    }
    
    private func setupUI() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        collectionView.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.left.equalToSuperview().offset(12)
            $0.width.equalToSuperview().inset(12)
        }
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.width.height.equalToSuperview()
        }
    }

}
