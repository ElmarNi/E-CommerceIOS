//
//  UIComponents.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 06.12.23.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 12)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        commonInit(placeholder: placeholder)
    }
    
    init(placeholder: String, type: UIKeyboardType) {
        super.init(frame: .zero)
        self.keyboardType = type
        commonInit(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(placeholder: String) {
        self.placeholder = placeholder
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1).cgColor
    }
}

class PaddedPasswordTextField: PaddedTextField {
    override var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
    }
    
    override init(placeholder: String) {
        super.init(placeholder: placeholder)
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RoundedBlackButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CyanButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ErrorLabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.font = .systemFont(ofSize: 12, weight: .bold)
        self.textColor = .red
        self.isHidden = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        let fullString = NSMutableAttributedString(string: "\(text) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let redString = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        fullString.append(redString)
        self.attributedText = fullString
        self.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Spinner: UIActivityIndicatorView {
    init() {
        super.init(frame: .zero)
        self.hidesWhenStopped = true
    }
    
    init(color: UIColor) {
        super.init(frame: .zero)
        self.color = color
        self.hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
