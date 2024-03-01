//
//  ReviewTableViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 29.02.24.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let identifier = "ReviewTableViewCell"
    private let leftSide: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1.00)
        return label
    }()
    
    private let rightSide: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1.00)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(leftSide)
        addSubview(rightSide)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        leftSide.snp.makeConstraints { $0.top.left.bottom.equalToSuperview() }
        rightSide.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(leftSide.snp.right)
        }
    }
    
    func configure(leftSide: String, rightSide: String) {
        self.leftSide.text = leftSide
        self.rightSide.text = rightSide
    }
}
