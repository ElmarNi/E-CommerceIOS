//
//  HomeTitleView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 12.12.23.
//

import UIKit
import SnapKit

class HomeTitleView: UIView {
    private let spinner = Spinner()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    private var searchButtonLeadingConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileButton)
        addSubview(searchButton)
        spinner.startAnimating()
        profileButton.addSubview(spinner)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        profileButton.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
            make.width.height.equalTo(self.snp.height).inset(5)
        }
        
        searchButton.snp.makeConstraints { make in
            searchButtonLeadingConstraint = make.right.equalToSuperview().inset(40).constraint
            make.centerY.equalToSuperview()
            make.width.height.equalTo(self.snp.height).inset(5)
        }
        
        spinner.snp.makeConstraints { make in
            make.width.height.centerX.centerY.equalToSuperview()
        }
    }
    
    func configure(profileImage: UIImage?) {
        if profileImage == nil {
            searchButtonLeadingConstraint?.update(offset: 5)
        } else {
            searchButtonLeadingConstraint?.update(offset: -40)
        }
        
        profileButton.setImage(profileImage, for: .normal)
        spinner.stopAnimating()
    }
    
}
