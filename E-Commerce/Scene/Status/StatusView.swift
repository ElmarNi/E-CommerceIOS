//
//  StatusView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 30.01.24.
//

import UIKit
import SnapKit

class StatusView: UIView {
    
    var onAction: () -> Void = {}
    
    private let mainFrame = UIView(frame: .zero)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 14)
        return label
    }()
    
    private let button = RoundedButton(title: "")
    
    init(title: String, description: String, buttonTitle: String, image: UIImage?) {
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.image = image
        button.setTitle(buttonTitle, for: .normal)
        addSubview(mainFrame)
        mainFrame.addSubview(imageView)
        mainFrame.addSubview(titleLabel)
        mainFrame.addSubview(descriptionLabel)
        mainFrame.addSubview(button)
        isHidden = true
        setupUI()
        
        button.addTarget(self, action: #selector(buttontapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let descriptionLabelHeight = calculateHeightForText(text: descriptionLabel.text ?? "",
                                                            width: frame.width - 32,
                                                            font: UIFont(name: "PlusJakartaSans-Regular", size: 14)!)
        
        let titleLabelHeight = calculateHeightForText(text: titleLabel.text ?? "",
                                                      width: frame.width - 32,
                                                      font: UIFont(name: "PlusJakartaSans-Bold", size: 24)!)
        
        mainFrame.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.center.equalToSuperview()
            make.height.equalTo(356 + titleLabelHeight + descriptionLabelHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttontapped() {
        onAction()
    }
    
    private func setupUI() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(240)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.width.left.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.width.left.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.height.equalTo(60)
            make.width.left.equalToSuperview()
        }
    }
    
    private func calculateHeightForText(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        let boundingRect = NSString(string: text).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        
        return ceil(boundingRect.height)
    }
}
