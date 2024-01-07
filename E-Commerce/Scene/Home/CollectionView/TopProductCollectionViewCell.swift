//
//  TopProductCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.01.24.
//

import UIKit
import SnapKit

class TopProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopProductCollectionViewCell"
    private var pageViewController = PageRootViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pageViewController.view)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        pageViewController.view.snp.makeConstraints { make in
            make.left.top.width.height.equalToSuperview()
        }
    }
    
    func configure(_ data: [Product]) {
        pageViewController.configureHomePage(data)
    }
}
