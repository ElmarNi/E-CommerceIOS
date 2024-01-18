//
//  ProductCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 26.12.23.
//

import UIKit
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    private let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    private let wishlistButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.backgroundColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        button.clipsToBounds = true
        return button
    }()
    
    private let spinner = Spinner()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImage)
        coverImage.addSubview(spinner)
        spinner.startAnimating()
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(ratingLabel)
        addSubview(wishlistButton)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        ratingLabel.text = nil
    }
    
    private func setupUI() {
        coverImage.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(138)
        }
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        titleLabel.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(coverImage.snp.bottom).offset(8)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        ratingLabel.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom)
        }
        wishlistButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(6)
            make.top.equalToSuperview().offset(6)
            make.width.height.equalTo(24)
        }
        wishlistButton.layoutIfNeeded()
        wishlistButton.layer.cornerRadius = wishlistButton.frame.size.width / 2
    }
    
    func configure(product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        ratingLabel.text = "rating: \(product.rating)/5"
        guard let url = URL(string: product.thumbnail) else { return }
        coverImage.download(from: url, sessionDelegate: self) {[weak self] in
            self?.spinner.stopAnimating()
        }
    }
}
