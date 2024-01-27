//
//  SignUpViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 05.12.23.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let mainFrame = UIView()
    private let loadingView = LoadingView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 24)
        label.text = "Signup"
        label.numberOfLines = 1
        return label
    }()
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.numberOfLines = 1
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 14)
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        return label
    }()
    
    private let loginButton = CyanButton(title: "Login")
    
    private let fullnameLabel = UserLabel(text: "Fullname")
    
    private let fullnameTextField = PaddedTextField(placeholder: "Enter your fullname")
    
    private let fullnameError = ErrorLabel()
    
    private let usernameLabel = UserLabel(text: "Username")
    
    private let usernameTextField = PaddedTextField(placeholder: "Enter your Username")
    
    private let usernameError = ErrorLabel()
    
    private let passwordLabel = UserLabel(text: "Password")
    
    private let passwordTextField = PaddedTextField(placeholder: "Enter your Password", isSecureTextEntry: true)
    
    private let passwordError = ErrorLabel()
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let createAccountButton = RoundedButton(title: "Create Account")
    private let viewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = LogoTitleView()
        
        mainFrame.addSubview(titleLabel)
        mainFrame.addSubview(haveAccountLabel)
        mainFrame.addSubview(loginButton)
        mainFrame.addSubview(fullnameLabel)
        mainFrame.addSubview(fullnameTextField)
        mainFrame.addSubview(fullnameError)
        mainFrame.addSubview(usernameLabel)
        mainFrame.addSubview(usernameTextField)
        mainFrame.addSubview(usernameError)
        mainFrame.addSubview(passwordLabel)
        mainFrame.addSubview(passwordTextField)
        mainFrame.addSubview(passwordError)
        passwordTextField.addSubview(toggleButton)
        mainFrame.addSubview(createAccountButton)
        view.addSubview(mainFrame)
        view.addSubview(loadingView)
        
        for case let textField as UITextField in mainFrame.subviews {
            textField.delegate = self
        }
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        toggleButton.isSelected = !passwordTextField.isSecureTextEntry
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func createAccountButtonTapped() {
        guard let fullname = fullnameTextField.text?.trimmingCharacters(in: .whitespaces),
              let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces),
              let password = passwordTextField.text
        else { return }
        var isError = false
        fullnameError.isHidden = !fullname.isEmpty
        usernameError.isHidden = !username.isEmpty
        
        if fullname.isEmpty {
            fullnameError.text = "Please enter a fullname"
            fullnameTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else {
            fullnameError.text = ""
            fullnameTextField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
        }
        
        if username.isEmpty {
            usernameError.text = "Please enter a username"
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else {
            usernameError.text = ""
            usernameTextField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
        }
        
        if password.isEmpty {
            passwordError.isHidden = false
            passwordError.text = "Please enter a password"
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else if password.count < 8 {
            passwordError.isHidden = false
            passwordError.text = "Password must be contain min 8 characters"
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            isError = true
        }
        else {
            passwordError.isHidden = true
            passwordError.text = ""
            passwordTextField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
        }
        
        if !isError {
            loadingView.isHidden = false
            DispatchQueue.main.async {[weak self] in
                self?.viewModel.register(sessionDelegate: self, username: username, password: password, fullname: fullname) { [weak self] success in
                    if success {
                        self?.navigationController?.viewControllers = [LoginViewController()]
                    }
                    else {
                        self?.showAlert(title: "Error", message: "Something went wrong")
                    }
                    self?.loadingView.isHidden = true
                }
            }
        }
    }
    
    private func setupUI() {
        mainFrame.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { $0.left.right.top.equalToSuperview() }
        
        haveAccountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(haveAccountLabel.snp.right).offset(5)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(haveAccountLabel.snp.height)
        }
        
        fullnameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(24)
        }
        
        fullnameTextField.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(fullnameLabel.snp.bottom).offset(8)
        }
        
        fullnameError.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(fullnameTextField.snp.bottom).offset(4)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(fullnameError.snp.bottom).offset(16)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
        
        usernameError.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(4)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(usernameError.snp.bottom).offset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
        }
        
        passwordError.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(passwordError.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
        
        loadingView.snp.makeConstraints { $0.left.right.top.bottom.equalToSuperview() }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        textField.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1).cgColor
    }
    
}
