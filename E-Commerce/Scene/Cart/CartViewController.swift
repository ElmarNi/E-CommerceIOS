//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.12.23.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    internal let viewModel = CartViewModel()
    internal let loadingView = LoadingView()
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
                    if let isCartEmpty = isCartEmpty {
                        if !isCartEmpty {
                            self?.collectionView.reloadData()
                            self?.priceLabel.text = "$\(String(self?.viewModel.cart?.total ?? 0).replacingOccurrences(of: ".0", with: ""))"
                            self?.checkoutButton.setTitle("Checkout (\(self?.viewModel.cart?.totalProducts ?? 0))", for: .normal)
                            self?.collectionView.isHidden = false
                            self?.totalLabel.isHidden = false
                            self?.priceLabel.isHidden = false
                            self?.checkoutButton.isHidden = false
                        }
                        else {
                            
                        }
                    }
                }
                self?.spinner.stopAnimating()
            }
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
    }
    
    private func setupUI() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        checkoutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
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
    }
}
