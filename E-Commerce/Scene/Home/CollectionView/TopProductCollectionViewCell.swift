//
//  TopProductCollectionViewCell.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.01.24.
//

import UIKit
import SnapKit

class TopProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopProductCollectionViewCell"
    private var count = 0;
    private var index = 0;
    
    private let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let spinner = Spinner()
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.0]
        return gradientLayer
    }()
    
    private let saleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 10)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    private let indicatorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1)
        //        stackView.layer.cornerRadius = 12
        //        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 12
        
        coverImage.addSubview(spinner)
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(indicatorsStackView)
        indicatorsStackView.addArrangedSubview(UIView())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = coverImage.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        saleLabel.text = nil
        titleLabel.text = nil
    }
    
    func configure(product: Product, count: Int, index: Int) {
        titleLabel.text = product.title
        self.count = count
        self.index = index
        
        for subview in indicatorsStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        indicatorsStackView.addArrangedSubview(UIView())
        for i in 0..<count {
            indicatorsStackView.addArrangedSubview(createIndicator(isActive: i == index))
        }
        indicatorsStackView.addArrangedSubview(UIView())
        
        indicatorsStackView.snp.makeConstraints { make in
            make.width.equalTo((count + 2) * 10)
        }
        titleLabel.snp.makeConstraints { make in
            make.right.equalTo(indicatorsStackView.snp.left)
        }
        
        guard let url = URL(string: product.thumbnail) else { return }
        coverImage.download(from: url, sessionDelegate: self) {[weak self] in
            self?.spinner.stopAnimating()
        }
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(10)
        }
        coverImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        indicatorsStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(16)
            make.width.equalTo(100)
        }
        coverImage.layer.addSublayer(gradientLayer)
    }
    
    private func createIndicator(isActive: Bool = false) -> UIButton {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.backgroundColor = isActive ? UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1) : UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.snp.makeConstraints { make in
            make.height.equalTo(6)
        }
        return button
    }
    
}
