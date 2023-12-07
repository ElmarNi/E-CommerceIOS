//
//  EntryViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit
import SnapKit

class EntryViewController: UIViewController {
    private var pageViewController = PageRootViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        setupUI()    }
    
    private func setupUI() {
        pageViewController.view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }

}
