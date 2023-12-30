//
//  TitleView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 26.12.23.
//

import UIKit
import SnapKit

class TitleView: UICollectionReusableView {
    static let identifier = "TitleView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    private let seeAllBtn: CyanButton = {
        let btn = CyanButton(title: "SEE ALL")
        btn.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 10)
        return btn
    }()
    
    var onAction: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(seeAllBtn)
        seeAllBtn.addTarget(self, action: #selector(seeAllBtnTapped(_:)), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func seeAllBtnTapped(_ sender: UIButton) {
        onAction()
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        seeAllBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
    }
    
    func configure(title: String, sectionIndex: Int) {
        titleLabel.text = title
        seeAllBtn.tag = sectionIndex
    }
}
