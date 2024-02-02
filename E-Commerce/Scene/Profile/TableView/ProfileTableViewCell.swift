//
//  ProfileTableViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 01.02.24.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00) // Set your desired border color
        return view
    }()
    private let titleIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let rightArrowIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Vector")
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1.00)
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bottomBorderView)
        addSubview(titleIconImageView)
        addSubview(rightArrowIconImageView)
        addSubview(titleLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        bottomBorderView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        titleIconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        rightArrowIconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleIconImageView.snp.right).offset(8)
            make.right.equalTo(rightArrowIconImageView.snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
        titleIconImageView.image = UIImage(named: title)
    }
    
}
