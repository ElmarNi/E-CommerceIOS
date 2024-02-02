//
//  ProfileSupportViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 02.02.24.
//

import UIKit

class ProfileSupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

}
