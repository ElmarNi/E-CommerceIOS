//
//  LoadingView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    private let spinner = Spinner(color: .white)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black.withAlphaComponent(0.8)
        isHidden = true
        addSubview(spinner)
        spinner.startAnimating()
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSpinnerAndBGColor(spinnerColor: UIColor, bgColor: UIColor) {
        spinner.color = spinnerColor
        backgroundColor = bgColor
    }
}
