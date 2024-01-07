//
//  HomePageViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 30.12.23.
//

import UIKit
import SnapKit

class HomePageViewController: UIViewController {
    
    private let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    private let innerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0.013, green: 0.013, blue: 0.013, alpha: 0.4).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerView.addSubview(coverImage)
        innerView.layer.addSublayer(gradientLayer)
        innerView.addSubview(titleLabel)
        view.addSubview(innerView)
        setupUI()
    }
    
    private func setupUI() {
        innerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().inset(4)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(10)
        }
        coverImage.snp.makeConstraints { make in
            make.left.top.width.height.equalToSuperview()
        }
        gradientLayer.bounds = view.bounds
        gradientLayer.position = view.center
    }
    
    func configure(product: Product) {
        titleLabel.text = product.title
        guard let url = URL(string: product.thumbnail) else { return }
        coverImage.download(from: url, sessionDelegate: self)
    }
}
