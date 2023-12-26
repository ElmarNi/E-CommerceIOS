//
//  LogoTitleView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 05.12.23.
//

import UIKit
import SnapKit

class LogoTitleView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView.snp.makeConstraints { make in
            make.left.width.centerY.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
}
