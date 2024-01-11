//
//  CategoryCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 26.12.23.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1).cgColor
        clipsToBounds = true
        addSubview(titleLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(category: String) {
        titleLabel.text = category
    }
}
