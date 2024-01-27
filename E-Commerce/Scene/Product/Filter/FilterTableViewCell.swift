//
//  FilterTableViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.01.24.
//

import UIKit
import SnapKit

class FilterTableViewCell: UITableViewCell {
    static let identifier = "FilterTableViewCell"
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
        return label
    }()
    private let icon = UIImageView(image: UIImage(named: "unchecked"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(title)
        addSubview(icon)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(36)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(12)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(12)
            make.height.equalToSuperview().inset(12)
        }
    }
    
    func selected() {
        icon.image = UIImage(named: "checked")
    }
    
    func unSelected() {
        icon.image = UIImage(named: "unchecked")
    }
    
    func configure(text: String?) {
        title.text = text
    }
    
}
