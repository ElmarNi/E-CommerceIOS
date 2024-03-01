//
//  ReviewTableHeaderView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 01.03.24.
//

import UIKit

class ReviewTableHeaderView: UITableViewHeaderFooterView {
    static let identifier = "ReviewTableHeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 14)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
