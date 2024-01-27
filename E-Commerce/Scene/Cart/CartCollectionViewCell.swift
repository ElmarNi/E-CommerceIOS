//
//  CartCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import UIKit
import SnapKit

class CartCollectionViewCell: UICollectionViewCell {
    static let identifier = "CartCollectionViewCell"
    var deleteButtonOnAction: () -> Void = {}
    var priceChangeOnAction: (Float) -> Void = {_ in }
    private var cartProduct: CartProduct?
    private let spinner = Spinner()
    
    private let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private let quantityStackView: UIStackView = {
        let sv = UIStackView()
        sv.layer.cornerRadius = 8
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor(red: 0.957, green: 0.961, blue: 0.992, alpha: 1).cgColor
        return sv
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        coverImage.addSubview(spinner)
        spinner.startAnimating()
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(priceLabel)
        quantityStackView.addSubview(minusButton)
        quantityStackView.addSubview(quantityLabel)
        quantityStackView.addSubview(plusButton)
        addSubview(quantityStackView)
        addSubview(deleteButton)
        addSubview(totalLabel)
        setupUI()
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        priceLabel.text = nil
        quantityLabel.text = nil
        totalLabel.text = nil
        minusButton.tintColor = .black
    }
    
    @objc private func plusButtonTapped() {
        guard let text = quantityLabel.text, var num = Int(text) else { return }
        if num < cartProduct?.quantity ?? 0 {
            num += 1
            quantityLabel.text = "\(num)"
            minusButton.tintColor = .black
            plusButton.tintColor = (num == cartProduct?.quantity) ? UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1) : .black
            totalLabel.text = "Total: $\(String(Float(num) * (cartProduct?.price ?? 0)).replacingOccurrences(of: ".0", with: ""))"
            priceChangeOnAction(cartProduct?.price ?? 0)
        } else {
            shake()
        }
    }
    
    @objc private func minusButtonTapped() {
        guard let text = quantityLabel.text, var num = Int(text) else { return }
        if num > 1 {
            num -= 1
            quantityLabel.text = "\(num)"
            minusButton.tintColor = (num == 1) ? UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1) : .black
            plusButton.tintColor = .black
            totalLabel.text = "Total: $\(String(Float(num) * (cartProduct?.price ?? 0)).replacingOccurrences(of: ".0", with: ""))"
            priceChangeOnAction(-(cartProduct?.price ?? 0))
        } else {
            shake()
        }
    }
    
    private func shake() {
        quantityStackView.layer.borderColor = UIColor.red.cgColor
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: quantityStackView.center.x - 5, y: quantityStackView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: quantityStackView.center.x + 5, y: quantityStackView.center.y))
        quantityStackView.layer.add(animation, forKey: "position")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {[weak self] in
            self?.quantityStackView.layer.borderColor = UIColor(red: 0.957, green: 0.961, blue: 0.992, alpha: 1).cgColor
        }
    }
    
    private func setupUI() {
        coverImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.width.equalTo(120)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(8)
            make.top.right.equalToSuperview()
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalToSuperview()
        }
        quantityStackView.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(96)
            make.bottom.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(4)
            make.width.height.equalTo(24)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().inset(4)
            make.width.height.equalTo(24)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(24)
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(plusButton.snp.left)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(8)
            make.bottom.equalTo(quantityStackView.snp.top).offset(-8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
            make.width.height.equalTo(24)
        }
    }
    
    func configure(cartProduct: CartProduct?) {
        self.cartProduct = cartProduct
        titleLabel.text = cartProduct?.title
        priceLabel.text = "Price: $\(String(cartProduct?.price ?? 0).replacingOccurrences(of: ".0", with: ""))"
        totalLabel.text = "Total: $\(String(cartProduct?.total ?? 0).replacingOccurrences(of: ".0", with: ""))"
        quantityLabel.text = "\(cartProduct?.quantity ?? 0)"
        if cartProduct?.quantity == 1 {
            minusButton.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        }
        guard let url = URL(string: cartProduct?.thumbnail ?? "") else { return }
        coverImage.download(from: url, sessionDelegate: self) {[weak self] in
            self?.spinner.stopAnimating()
        }
    }
}
