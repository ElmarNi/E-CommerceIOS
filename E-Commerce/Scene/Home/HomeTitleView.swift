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
    var searchButtonOnAction: (Int) -> Void = {_ in }
    var profileButtonOnAction: () -> Void = {}
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setImage(UIImage(named: "no-image"), for: .normal)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tag = 0
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
        searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func searchButtonTapped(_ sender: UIButton) {
        searchButtonOnAction(sender.tag)
        changeSearchButtonImage()
    }
    
    @objc private func profileButtonTapped() {
        profileButtonOnAction()
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
        
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    func changeSearchButtonImage(hide: Bool = false) {
        searchButton.tag = searchButton.tag == 0 && !hide ? 1 : 0
        searchButton.setImage(UIImage(named: searchButton.tag == 0 ? "search" : "close"), for: .normal)
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
