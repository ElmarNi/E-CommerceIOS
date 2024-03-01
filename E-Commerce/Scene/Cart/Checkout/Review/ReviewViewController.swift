//
//  ReviewViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 19.02.24.
//

import UIKit
import SnapKit

class ReviewViewController: UIViewController {
    
    internal let cartViewModel = CartViewModel()
    internal let profileViewModel = ProfileViewModel()
    internal let tableView = UITableView()
    internal var userData = [String:String]()
    internal var orderData = [String:String]()
    private let placeOrderButton = RoundedButton(title: "Place Order")
    
    private let loadingView: LoadingView = {
        let lv = LoadingView()
        lv.isHidden = false
        lv.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .systemBackground)
        return lv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        view.addSubview(tableView)
        view.addSubview(placeOrderButton)
        view.addSubview(loadingView)
        data()
        setupUI()
        configureTableView()
        
        placeOrderButton.addTarget(self, action: #selector(placeOrderButtonTapped), for: .touchUpInside)
    }
    
    @objc private func placeOrderButtonTapped() {
        
    }
    
    private func data() {
        guard let userID = UserDefaults.standard.value(forKey: "userID") as? Int else { return }
        let group = DispatchGroup()
        var cart: Cart?
        var user: User?
        
        group.enter()
        group.enter()
        
        cartViewModel.cart(sessionDelegate: self, userId: userID) {[weak self] isError, errorString, isCartEmpty in
            !isError ? cart = self?.cartViewModel.cart : nil
            group.leave()
        }
        profileViewModel.user(sessionDelegate: self, userID: userID) {[weak self] isError, errorString in
            !isError ? user = self?.profileViewModel.user : nil
            group.leave()
        }
        group.notify(queue: .main) {[weak self] in
            guard let cart = cart, let user = user, let self = self else { return }
            self.userData = ["Full Name": "\(user.firstName) \(user.lastName)",
                             "Email": user.email,
                             "City": user.address.city,
                             "Address": user.address.address,
                             "Postal Code": user.address.postalCode]
            self.orderData = ["Subtotal": "\(cart.total)"]
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
        }
    }
    
    private func setupUI() {
        placeOrderButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-12)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(placeOrderButton.snp.top).offset(-12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        loadingView.snp.makeConstraints({$0.edges.equalToSuperview()})
    }
    
}
