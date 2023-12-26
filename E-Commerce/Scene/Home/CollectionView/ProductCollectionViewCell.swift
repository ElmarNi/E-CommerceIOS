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
//        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = .systemFont(ofSize: 21)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImage)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        coverImage.snp.makeConstraints { make in
            make.left.width.top.height.equalToSuperview()
//            make.height.equalTo(138)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(coverImage.snp.bottom).offset(8)
        }
        coverImage.backgroundColor = .red
    }
    
    func configure(product: Product) {
        titleLabel.text = product.title
        guard let url = URL(string: product.thumbnail) else { return }
        coverImage.download(from: url, sessionDelegate: self)
        print(product.title)
    }
}
