//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.12.23.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    internal let customView = UIView()
    
    internal let viewModel = CartViewModel()
    internal let loadingView = LoadingView()
    internal let emptyView = StatusView(title: "Your cart is empty",
                                       description: "Looks like you have not added anything in your cart. Go ahead and explore top categories. Looks like you have not added anything in your cart. Go ahead and explore top categories.",
                                       buttonTitle: "Explore Categories", 
                                       image: UIImage(named: "cart"))
    private let spinner = Spinner()
    internal let collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider: { _, _ in
                    CartViewController.configureCollectionViewLayout()
                }
            ))
        cv.showsVerticalScrollIndicator = false
        cv.isHidden = true
        return cv
    }()
    
    internal let checkoutButton: RoundedButton = {
        let btn = RoundedButton(title: "Checkout")
        btn.isHidden = true
        return btn
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        label.text = "Total"
        label.isHidden = true
        return label
    }()
    
    internal let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Cart"
        view.addSubview(collectionView)
        view.addSubview(spinner)
        view.addSubview(checkoutButton)
        view.addSubview(totalLabel)
        view.addSubview(priceLabel)
        view.addSubview(emptyView)
        
        setupUI()
        setupCollectionView()
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first {
            
            loadingView.frame = keyWindow.bounds
            keyWindow.addSubview(loadingView)
        }
        
        emptyView.onAction = { [weak self] in
            self?.navigationController?.tabBarController?.selectedIndex = 1
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spinner.startAnimating()
        if let userId = UserDefaults.standard.value(forKey: "userID") as? Int {
            viewModel.carts(sessionDelegate: self, userId: userId) {[weak self] isError, errorString, isCartEmpty in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    if var isCartEmpty = isCartEmpty {
                        if !isCartEmpty {
                            self?.collectionView.reloadData()
                            self?.priceLabel.text = "$\(String(self?.viewModel.cart?.total ?? 0).replacingOccurrences(of: ".0", with: ""))"
                            self?.checkoutButton.setTitle("Checkout (\(self?.viewModel.cart?.totalProducts ?? 0))", for: .normal)
                            self?.hideOrDisplay(isEmpty: isCartEmpty)
                        }
                        else {
                            self?.hideOrDisplay(isEmpty: isCartEmpty)
                        }
                    }
                }
                self?.spinner.stopAnimating()
            }
        }
        else {
            hideOrDisplay(isEmpty: true)
            spinner.stopAnimating()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.cart = nil
        priceLabel.text = nil
        collectionView.reloadData()
        
        collectionView.isHidden = true
        totalLabel.isHidden = true
        priceLabel.isHidden = true
        checkoutButton.isHidden = true
        emptyView.isHidden = true
    }
    
    internal func hideOrDisplay(isEmpty: Bool) {
        collectionView.isHidden = isEmpty
        totalLabel.isHidden = isEmpty
        priceLabel.isHidden = isEmpty
        checkoutButton.isHidden = isEmpty
        emptyView.isHidden = !isEmpty
    }
    
    private func setupUI() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        checkoutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        totalLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(checkoutButton.snp.top).offset(-16)
        }
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(checkoutButton.snp.top).offset(-16)
        }
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalTo(totalLabel.snp.top).offset(-24)
        }
        emptyView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }
    }
}
