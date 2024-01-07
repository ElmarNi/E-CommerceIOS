//
//  EntryViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit
import SnapKit

class EntryViewController: UIViewController {
    private var data = [
        EntryPage(title: "Explore a wide range of products", 
                  description: "Explore a wide range of products at your fingertips. QuickMart offers an extensive collection to suit your needs.",
                  imageName: "entry1"),
        EntryPage(title: "Unlock exclusive offers and discounts",
                  description: "Get access to limited-time deals and special promotions available only to our valued customers.",
                  imageName: "entry2"),
        EntryPage(title: "Safe and secure payments",
                  description: "QuickMart employs industry-leading encryption and trusted payment gateways to safeguard your financial information.",
                  imageName: "entry3", isLogin: true)
    ]
    private var pageViewController = PageRootViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        pageViewController.configureEntryPage(data)
        addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        pageViewController.view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
}
