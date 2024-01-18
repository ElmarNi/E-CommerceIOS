//
//  SearchView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 18.01.24.
//

import UIKit
import SnapKit

class SearchView: UIView {
    var onAction: (String) -> Void = {_ in }
    private let serachTextField = PaddedTextField(placeholder: "Search", padding: UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 36))
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        alpha = 0
        addSubview(serachTextField)
        serachTextField.addSubview(searchButton)
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
        serachTextField.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleShow(hide: Bool = false) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.alpha == 0 && !hide ? 1 : 0
        }
        endEditing(true)
        serachTextField.text = nil
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc private func searchButtonTapped() {
        guard let text = serachTextField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return }
        onAction(text)
    }
    
    private func setupUI() {
        serachTextField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
        }
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else { return false }
        onAction(text)
        return true
    }
}
