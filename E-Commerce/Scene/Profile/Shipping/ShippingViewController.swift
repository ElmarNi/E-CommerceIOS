//
//  ShippingViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import UIKit
import SnapKit

class ShippingViewController: UIViewController {
    var onAction: ((Bool, String?) -> Void)? = nil
    private let viewModel = ShippingViewModel()
    private var loadingView = LoadingView()
    
    private let addressLabel = UserLabel(text: "Address")
    private let addressTextField = PaddedTextField(placeholder: "Enter your address")
    private let addressError = ErrorLabel(text: "Please enter address")
    
    private let cityLabel = UserLabel(text: "City")
    private let cityTextField = PaddedTextField(placeholder: "Enter your city")
    private let cityError = ErrorLabel(text: "Please enter city")
    
    private let postalCodeLabel = UserLabel(text: "Postal Code")
    private let postalCodeTextField = PaddedTextField(placeholder: "Enter your postal code")
    private let postalCodeError = ErrorLabel(text: "Please enter postalCode")
    
    private let saveButton = RoundedButton(title: "Save")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(addressLabel)
        view.addSubview(addressTextField)
        view.addSubview(addressError)
        
        view.addSubview(cityLabel)
        view.addSubview(cityTextField)
        view.addSubview(cityError)
        
        view.addSubview(postalCodeLabel)
        view.addSubview(postalCodeTextField)
        view.addSubview(postalCodeError)
        
        view.addSubview(saveButton)
        view.addSubview(loadingView)
        
        setupUI()
        address()
        
        for case let textField as UITextField in view.subviews {
            textField.delegate = self
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        guard let address = addressTextField.text,
              let city = cityTextField.text,
              let postalCode = postalCodeTextField.text
        else { return }
        
        addressError.isHidden = !address.isEmpty
        cityError.isHidden = !city.isEmpty
        postalCodeError.isHidden = !postalCode.isEmpty
        
        address.isEmpty ? addressTextField.layer.borderColor = UIColor.red.cgColor : nil
        city.isEmpty ? cityTextField.layer.borderColor = UIColor.red.cgColor : nil
        postalCode.isEmpty ? postalCodeTextField.layer.borderColor = UIColor.red.cgColor : nil
        
        if !address.isEmpty, !city.isEmpty, !postalCode.isEmpty {
            if onAction == nil {
                loadingView.changeSpinnerAndBGColor(spinnerColor: .white, bgColor: .black.withAlphaComponent(0.8))
            }
            else {
                loadingView.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .white)
            }
            loadingView.isHidden = false
            if let userID = UserDefaults.standard.value(forKey: "userID") as? Int {
                let address = Address(address: addressTextField.text ?? "", city: cityTextField.text ?? "", postalCode: postalCodeTextField.text ?? "")
                viewModel.update(sessionDelegate: self, userID: userID, address: address) {[weak self] isError, message in
                    if let onAction = self?.onAction, !isError {
                        onAction(!isError, message)
                    }
                    else {
                        self?.showAlert(title: isError ? "Error" : "Success", message: message)
                    }
                    self?.loadingView.isHidden = true
                }
            }
            else {
                loadingView.isHidden = true
            }
        }
    }
    
    private func address() {
        loadingView.isHidden = false
        loadingView.changeSpinnerAndBGColor(spinnerColor: .systemGray, bgColor: .systemBackground)
        if let userID = UserDefaults.standard.value(forKey: "userID") as? Int {
            viewModel.user(sessionDelegate: self, userID: userID) {[weak self] isError, errorString in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    self?.addressTextField.text = self?.viewModel.address?.address
                    self?.cityTextField.text = self?.viewModel.address?.city
                    self?.postalCodeTextField.text = self?.viewModel.address?.postalCode
                    
                    if let subViews = self?.view.subviews {
                        for case let textField as UITextField in subViews {
                            if let text = textField.text, text.isEmpty {
                                textField.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00).cgColor
                            }
                            else {
                                textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
                            }
                        }
                    }
                }
                self?.loadingView.isHidden = true
            }
        }
        else {
            loadingView.isHidden = true
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUI() {
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
        }
        
        addressError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(addressTextField.snp.bottom).offset(8)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(addressError.snp.bottom).offset(8)
        }
        
        cityTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cityLabel.snp.bottom).offset(8)
        }
        
        cityError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(cityTextField.snp.bottom).offset(8)
        }
        
        postalCodeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(cityError.snp.bottom).offset(8)
        }
        
        postalCodeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(postalCodeLabel.snp.bottom).offset(8)
        }
        
        postalCodeError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(postalCodeTextField.snp.bottom).offset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(postalCodeError.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
        
        loadingView.snp.makeConstraints({$0.edges.equalToSuperview()})
    }
    
}

extension ShippingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        textField.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00).cgColor
    }
    
}
