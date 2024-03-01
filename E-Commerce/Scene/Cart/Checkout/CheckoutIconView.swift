//
//  CheckoutIconView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 16.02.24.
//

import UIKit
import SnapKit

class CheckoutIconView: UIView {

    private let shippingIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "box"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let shippingLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping"
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        return label
    }()
    
    private let firstVectorIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "vector 1"))
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let paymentcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "card-tick"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let paymentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Payment"
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        return label
    }()
    
    private let secondVectorIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "vector 1"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let reviewIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "clipBoard"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Review"
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        return label
    }()
    
    init(step: Int) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        addSubview(shippingIcon)
        addSubview(shippingLabel)
        addSubview(firstVectorIcon)
        
        addSubview(paymentcon)
        addSubview(paymentLabel)
        addSubview(secondVectorIcon)
        
        addSubview(reviewIcon)
        addSubview(reviewLabel)
        
        setupUI()
        
        switch step {
        case 1:
            shippingLabel.textColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1.00)
            paymentLabel.textColor = .black
            shippingIcon.image = UIImage(named: "box-colored")
            paymentcon.setImageColor(color: .black)
        case 2:
            shippingLabel.textColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1.00)
            paymentLabel.textColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1.00)
            reviewLabel.textColor = .black
            shippingIcon.image = UIImage(named: "box-colored")
            paymentcon.image = UIImage(named: "card-tick-colored")
            reviewIcon.setImageColor(color: .black)
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        shippingIcon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.width.equalTo(24)
            make.top.equalToSuperview()
        }
        
        shippingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shippingIcon.snp.centerX)
            make.top.equalTo(shippingIcon.snp.bottom)
        }
        
        paymentcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(24)
            make.top.equalToSuperview()
        }
        
        paymentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(paymentcon.snp.centerX)
            make.top.equalTo(paymentcon.snp.bottom)
        }
        
        firstVectorIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(shippingIcon.snp.right).offset(28)
            make.right.equalTo(paymentcon.snp.left).offset(-28)
        }
        
        reviewIcon.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.width.equalTo(24)
            make.top.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.centerX.equalTo(reviewIcon.snp.centerX)
            make.top.equalTo(reviewIcon.snp.bottom)
        }
        
        secondVectorIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(paymentcon.snp.right).offset(28)
            make.right.equalTo(reviewIcon.snp.left).offset(-28)
        }
    }
    
}
