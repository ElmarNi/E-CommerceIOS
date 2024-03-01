//
//  ReviewItemsTableViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 29.02.24.
//

import UIKit

class ReviewItemsTableViewCell: UITableViewCell {
    static let identifier = "ReviewItemsTableViewCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        return label
    }()
    private let rightArrowIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Vector")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rightArrowIconImageView)
        addSubview(titleLabel)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        rightArrowIconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(rightArrowIconImageView.snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
