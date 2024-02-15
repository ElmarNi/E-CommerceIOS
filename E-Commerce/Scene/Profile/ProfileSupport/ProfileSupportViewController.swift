//
//  ProfileSupportViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 02.02.24.
//

import UIKit

class ProfileSupportViewController: UIViewController {
    private let mainTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: -20, left: 16, bottom: 12, right: 16)
        tv.isSelectable = false
        return tv
    }()
    
    let data: KeyValuePairs<String, [String]>
    let isFAQ: Bool
    
    init(data: KeyValuePairs<String, [String]>, isFAQ: Bool = false) {
        self.data = data
        self.isFAQ = isFAQ
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mainTextView)
        mainTextView.frame = view.bounds
        for i in 0..<data.count {
            appendAttributedString(text: data[i].key,
                       font: UIFont(name: "PlusJakartaSans-Bold", size: i == 0 && !isFAQ ? 24 : 14),
                       textColor: .black)
            
            for text in data[i].value {
                appendAttributedString(text: text,
                           font: UIFont(name: "PlusJakartaSans-Regular", size: 14),
                           isLast: text == data[i].value.last)
            }
        }
        
        if isFAQ {
            setupFAQContent()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func appendAttributedString(text: String, font: UIFont?, textColor: UIColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1.00), isLast: Bool = false) {
        guard let font = font else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
        let attrText = NSAttributedString(string: text, attributes: attributes)
        
        let total = NSMutableAttributedString()
        if let existingAttributedText = mainTextView.attributedText {
            total.append(existingAttributedText)
        }
        total.append(NSAttributedString(string: "\n"))
        total.append(attrText)
        isLast ? total.append(NSAttributedString(string: "\n")) : nil
        mainTextView.attributedText = total
    }

    private func setupFAQContent() {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PlusJakartaSans-Regular", size: 14) ?? .systemFont(ofSize: 14),
                                                         .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        
        let attrText = NSAttributedString(string: "For any query, you can visit our website for Help Center at Quickmart.com",
                                          attributes: attributes)
        
        let total = NSMutableAttributedString()
        if let existingAttributedText = mainTextView.attributedText {
            total.append(existingAttributedText)
        }
        total.append(NSAttributedString(string: "\n"))
        total.append(attrText)
        total.addAttribute(NSAttributedString.Key.link, value: "https://dummyjson.com/docs/products", range: total.mutableString.range(of: "Help Center"))
        mainTextView.attributedText = total
    }
}
