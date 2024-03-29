//
//  LoginViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 05.12.23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let mainFrame = UIView()
    private let loadingView = LoadingView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 24)
        label.text = "Login"
        label.numberOfLines = 1
        return label
    }()
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.numberOfLines = 1
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 14)
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        return label
    }()
    
    private let signupButton = CyanButton(title: "Signup")
    
    private let usernameLabel = UserLabel(text: "Username")
    
    private let usernameTextField = PaddedTextField(placeholder: "Enter your Username")
    
    private let passwordLabel = UserLabel(text: "Password")
    
    private let passwordTextField = PaddedTextField(placeholder: "Enter your Password", isSecureTextEntry: true)
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let loginButton = RoundedButton(title: "Login")
    
    private let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = LogoTitleView()
        mainFrame.addSubview(titleLabel)
        mainFrame.addSubview(haveAccountLabel)
        mainFrame.addSubview(signupButton)
        mainFrame.addSubview(usernameLabel)
        mainFrame.addSubview(usernameTextField)
        mainFrame.addSubview(passwordLabel)
        mainFrame.addSubview(passwordTextField)
        passwordTextField.addSubview(toggleButton)
        mainFrame.addSubview(loginButton)
        view.addSubview(mainFrame)
        view.addSubview(loadingView)
        
        for case let textField as UITextField in mainFrame.subviews {
            textField.delegate = self
        }
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        toggleButton.isSelected = !passwordTextField.isSecureTextEntry
    }
    
    @objc private func signupButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text
        else { return }
        
        loadingView.isHidden = false
        
        DispatchQueue.main.async {[weak self] in
            self?.viewModel.login(sessionDelegate: self, username: username, password: password) {[weak self] success in
                if success {
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                    
                    let tabBarController = TabBarController()
                    sceneDelegate.window?.rootViewController = tabBarController
                    
                    if let navigationController = tabBarController.navigationController {
                        navigationController.popToRootViewController(animated: false)
                    }
                    UserDefaults.standard.setValue(true, forKey: "isLaunched")
                }
                else {
                    self?.showAlert(title: "Error", message: "Username or Passowrd is wrong")
                }
                self?.loadingView.isHidden = true
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
        
        signupButton.snp.makeConstraints { make in
            make.left.equalTo(haveAccountLabel.snp.right).offset(5)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(haveAccountLabel.snp.height)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(signupButton.snp.bottom).offset(16)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.height.equalTo(60)
        }
        
        loadingView.snp.makeConstraints { $0.left.right.top.bottom.equalToSuperview() }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        textField.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00).cgColor
    }
    
}
