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
    internal let emptyView = StatusView(title: "Your cart is empty",
                                       description: "Looks like you have not added anything in your cart. Go ahead and explore top categories. Looks like you have not added anything in your cart. Go ahead and explore top categories.",
                                       buttonTitle: "Explore Categories", 
                                       image: UIImage(named: "cart"))
    
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
        view.addSubview(checkoutButton)
        view.addSubview(totalLabel)
        view.addSubview(priceLabel)
        view.addSubview(emptyView)
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .systemBackground)
        setupUI()
        setupCollectionView()
//        if let keyWindow = UIApplication.shared.connectedScenes
//            .filter({$0.activationState == .foregroundActive})
//            .map({$0 as? UIWindowScene})
//            .compactMap({$0})
//            .first?.windows
//            .filter({$0.isKeyWindow}).first {
//            
//            loadingView.frame = keyWindow.bounds
//            keyWindow.addSubview(loadingView)
//        }
        
        emptyView.onAction = { [weak self] in
            self?.navigationController?.tabBarController?.selectedIndex = 1
        }
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingView.isHidden = false
        cart()
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
    
    @objc private func checkoutButtonTapped() {
        let shippingVC = ShippingViewController()
        let paymentVC = PaymentViewController()
        checkOutControllerCreator(step: 0, secondController: shippingVC)
        
        shippingVC.onAction = {[weak self] success, message in
            success ? self?.checkOutControllerCreator(step: 1, secondController: paymentVC) : self?.showAlert(title: "Error", message: message)
            self?.loadingView.isHidden = true
        }
    }
    
    private func checkOutControllerCreator(step: Int, secondController: UIViewController) {
        let container = UIViewController()
        container.view.backgroundColor = .systemBackground
        switch step {
        case 0: container.title = "Shipping"
        case 1: container.title = "Payment"
        default:
            break
        }
        let checkoutIconView = CheckoutIconView(step: step)
        
        container.view.addSubview(checkoutIconView)
        container.view.addSubview(secondController.view)
        
        checkoutIconView.snp.makeConstraints { make in
            make.top.equalTo(container.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(48)
            make.width.equalToSuperview().inset(48)
            make.height.equalTo(44)
        }
        
        secondController.view.snp.makeConstraints { make in
            make.top.equalTo(checkoutIconView.snp.bottom).offset(16)
            make.left.width.bottom.equalToSuperview()
        }
        navigationController?.pushViewController(container, animated: true)
    }
    
    private func cart() {
        if let userId = UserDefaults.standard.value(forKey: "userID") as? Int {
            viewModel.cart(sessionDelegate: self, userId: userId) {[weak self] isError, errorString, isCartEmpty in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    if let isCartEmpty = isCartEmpty {
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
                self?.loadingView.isHidden = true
            }
        }
        else {
            hideOrDisplay(isEmpty: true)
            loadingView.isHidden = true
        }
    }
    
    private func setupUI() {
        loadingView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
