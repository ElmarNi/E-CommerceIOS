//
//  ChangePasswordViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    
    private let viewModel = ChangePasswordViewModel()
    private let loadingView = LoadingView()
    
    private let newPasswordLabel = UserLabel(text: "New Password")
    private let newPasswordTextField = PaddedTextField(placeholder: "Enter your new password", isSecureTextEntry: true)
    private let newPasswordError = ErrorLabel(text: "Please enter new password")
    
    private let confirmPasswordLabel = UserLabel(text: "Confirm Password")
    private let confirmPasswordTextField = PaddedTextField(placeholder: "Enter your new password", isSecureTextEntry: true)
    private let confirmPasswordError = ErrorLabel()
    
    private let saveButton = RoundedButton(title: "Save")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Change Password"
        view.addSubview(newPasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordError)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(confirmPasswordError)
        view.addSubview(saveButton)
        view.addSubview(loadingView)
        
        for case let textField as UITextField in view.subviews {
            textField.delegate = self
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        guard let confirmPassword = confirmPasswordTextField.text, let newPassword = newPasswordTextField.text else { return }
        var isError = false
        newPasswordError.isHidden = !newPassword.isEmpty
        confirmPasswordError.isHidden = !confirmPassword.isEmpty
        
        if newPassword.isEmpty {
            newPasswordTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if confirmPassword.isEmpty {
            confirmPasswordError.text = "Please enter new password"
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if !newPassword.isEmpty, !confirmPassword.isEmpty, newPassword != confirmPassword {
            confirmPasswordError.isHidden = false
            confirmPasswordError.text = "Passwords aren't same"
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        
        if !isError, let userId = UserDefaults.standard.value(forKey: "userID") as? Int {
            loadingView.isHidden = false
            viewModel.changePassword(sessionDelegate: self, userID: userId, password: confirmPassword) {[weak self] isError, message in
                self?.showAlert(title: isError ? "Error" : "Success", message: message)
                self?.loadingView.isHidden = true
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUI() {
        newPasswordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(8)
        }
        
        newPasswordError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(8)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(newPasswordError.snp.bottom).offset(8)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(8)
        }
        
        confirmPasswordError.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(confirmPasswordError.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
        
        loadingView.snp.makeConstraints({$0.edges.equalToSuperview()})
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        textField.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1).cgColor
    }
    
}
