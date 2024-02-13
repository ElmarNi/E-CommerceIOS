//
//  PaymentViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import UIKit

class PaymentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment Method"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        
    }
    
}
