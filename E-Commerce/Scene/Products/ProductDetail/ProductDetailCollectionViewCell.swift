//
//  ProductDetailCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 26.01.24.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductDetailCollectionViewCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 18)
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    private let stockLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.435, green: 0.451, blue: 0.518, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(stockLabel)
        addSubview(ratingLabel)
        addSubview(descriptionLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(priceLabel.snp.left)
            make.top.equalToSuperview().offset(20)
        }

        stockLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(stockLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(ratingLabel.snp.bottom).offset(12)
        }
        
    }
    
    func configure(_ product: Product) {
        print(product)
        priceLabel.text = "$\(product.price)"
        titleLabel.text = product.title
        stockLabel.text = "stock: \(product.stock)"
        ratingLabel.text = "rating: \(product.rating)/5"
        descriptionLabel.text = "A wiki (/ˈwɪki/ ⓘ WI-kee) is a form of online hypertext publication that is collaboratively edited and managed by its own audience directly through a web browser. A typical wiki contains multiple pages for the subjects or scope of the project, and could be either open to the public or limited to use within an organization for maintaining its internal knowledge base.Wikis are enabled by wiki software, otherwise known as wiki engines. A wiki engine, being a form of a content management system, differs from other web-based systems such as blog software or static site generators, in that the content is created without any defined owner or leader, and wikis have little inherent structure, allowing structure to emerge according to the needs of the users.[1] Wiki engines usually allow content to be written using a simplified markup language and sometimes edited with the help of a rich-text editor.[2] There are dozens of different wiki engines in use, both standalone and part of other software, such as bug tracking systems. Some wiki engines are free and open-source, whereas others are"
    }
}
