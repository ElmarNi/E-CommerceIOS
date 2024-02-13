//
//  UIComponents.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 06.12.23.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    private var padding: UIEdgeInsets
    private var type: UIKeyboardType
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(placeholder: String, 
         padding: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 12),
         keyboardType: UIKeyboardType = .default,
         isSecureTextEntry: Bool = false)
    {
        self.padding = padding
        self.type = keyboardType
        super.init(frame: .zero)
        self.isSecureTextEntry = isSecureTextEntry
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
        self.font = UIFont(name: "PlusJakartaSans-Regular", size: 12)
    }
}

class RoundedButton: UIButton {
    init(title: String, bgColor: UIColor? = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1), borderColor: CGColor? = nil, textColor: UIColor? = .white) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        if let borderColor = borderColor {
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor
        }
        self.setTitleColor(textColor, for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
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
        self.titleLabel?.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ErrorLabel: UILabel {
    init(text: String? = nil) {
        super.init(frame: .zero)
        self.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 12)
        self.textColor = .red
        self.isHidden = true
        self.text = text
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
        self.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
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
