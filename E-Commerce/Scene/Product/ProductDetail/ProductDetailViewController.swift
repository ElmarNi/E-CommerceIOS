//
//  ProductDetailViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 24.01.24.
//

import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    internal var product: Product
    internal let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider:
                    { sectionIndex, _ in
                        return ProductDetailViewController.configureCollectionViewLayout(sectionIndex: sectionIndex)
                    }
            )
        )
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
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
    
    private let detailScrollView = UIScrollView()
    private let detailView = UIView()
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
    
    private let quantityTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        label.text = "Quantity"
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
        button.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
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
        button.tintColor = .black
        return button
    }()
    
    private let buyNowButton = RoundedButton(title: "Buy Now",
                                             bgColor: .white,
                                             borderColor: UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1).cgColor,
                                             textColor: .black)
    
    
    private let addCartButton = RoundedButton(title: "Add To Cart")
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(detailView)
        detailView.addSubview(collectionView)
        detailView.addSubview(priceLabel)
        detailView.addSubview(titleLabel)
        detailView.addSubview(stockLabel)
        detailView.addSubview(ratingLabel)
        detailView.addSubview(descriptionLabel)
        detailView.addSubview(quantityTextLabel)
        quantityStackView.addSubview(minusButton)
        quantityStackView.addSubview(quantityLabel)
        quantityStackView.addSubview(plusButton)
        detailView.addSubview(quantityStackView)
        detailView.addSubview(buyNowButton)
        detailView.addSubview(addCartButton)
        setupCollectionView()
        configure()
        setupUI()
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(addCartButtonTapped), for: .touchUpInside)
        buyNowButton.addTarget(self, action: #selector(buyNowButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let totalHeight = collectionView.bounds.height + priceLabel.bounds.height + stockLabel.bounds.height +
        ratingLabel.bounds.height +
        quantityTextLabel.bounds.height +
        quantityStackView.bounds.height +
        buyNowButton.bounds.height +
        calculateHeightForText(text: descriptionLabel.text ?? "",
                               width: view.frame.width - 32,
                               font: UIFont(name: "PlusJakartaSans-Regular", size: 14)!) +
        calculateHeightForText(text: titleLabel.text ?? "",
                               width: titleLabel.bounds.width,
                               font: UIFont(name: "PlusJakartaSans-Bold", size: 18)!)
        
        
        detailView.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: totalHeight + 92)
        detailScrollView.contentSize = CGSize(width: view.bounds.width, height: detailView.frame.height)
    }
    
    @objc private func plusButtonTapped() {
        guard let text = quantityLabel.text, var num = Int(text) else { return }
        if num < product.stock {
            num += 1
            quantityLabel.text = "\(num)"
            minusButton.tintColor = .black
            plusButton.tintColor = (num == product.stock) ? UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1) : .black
        } else {
            shake()
        }
    }
    
    @objc private func minusButtonTapped() {
        guard let text = quantityLabel.text, var num = Int(text) else { return }
        if num > 0 {
            num -= 1
            quantityLabel.text = "\(num)"
            minusButton.tintColor = (num == 0) ? UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1) : .black
            plusButton.tintColor = .black
        } else {
            shake()
        }
    }
    
    @objc private func addCartButtonTapped() {
        print("add cart tapped")
    }
        
    @objc private func buyNowButtonTapped() {
        guard let text = quantityLabel.text, let num = Int(text) else { return }
        if num > 0
        {
            navigationController?.tabBarController?.selectedIndex = 2
        }
        else {
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
        
        detailScrollView.snp.makeConstraints {$0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)}
        detailView.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 0)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(290)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(priceLabel.snp.left).offset(-12)
            make.top.equalTo(collectionView.snp.bottom).offset(24)
        }
        
        stockLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(stockLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(ratingLabel.snp.bottom).offset(12)
        }
        
        quantityTextLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
        }
        
        quantityStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(96)
            make.top.equalTo(quantityTextLabel.snp.bottom).offset(8)
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
        
        buyNowButton.snp.makeConstraints { make in
            make.top.equalTo(quantityLabel.snp.bottom).offset(52)
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).inset(4)
            make.height.equalTo(60)
        }
        
        addCartButton.snp.makeConstraints { make in
            make.top.equalTo(quantityLabel.snp.bottom).offset(52)
            make.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).inset(4)
            make.height.equalTo(60)
        }
        
    }
    
    private func configure() {
        priceLabel.text = "$\(String(product.price).replacingOccurrences(of: ".0", with: ""))"
        titleLabel.text = product.title
        stockLabel.text = "stock: \(product.stock)"
        ratingLabel.text = "rating: \(product.rating)/5"
        descriptionLabel.text = product.description
    }
    
    private func calculateHeightForText(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        let boundingRect = NSString(string: text).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        
        return ceil(boundingRect.height)
    }
    
}
