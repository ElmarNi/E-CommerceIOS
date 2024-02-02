//
//  ProfileTableHeaderView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 01.02.24.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    static let identifier = "ProfileTableHeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 14)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        backgroundColor = .red
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
