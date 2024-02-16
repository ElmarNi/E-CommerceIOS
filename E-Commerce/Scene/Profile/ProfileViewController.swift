//
//  ProfileViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 07.12.23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
        view.isHidden = true
        return view
    }()
    private let textStackView = UIStackView()
    internal let viewModel = ProfileViewModel()
    private let spinner = Spinner()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 16)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.108, green: 0.105, blue: 0.105, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 14)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
        return imageView
    }()
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logout"), for: .normal)
        return button
    }()
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.isHidden = true
        return btn
    }()
    internal let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        spinner.startAnimating()
        textStackView.addSubview(nameLabel)
        textStackView.addSubview(emailLabel)
        titleView.addSubview(textStackView)
        titleView.addSubview(profileImageView)
        titleView.addSubview(logoutButton)
        
        view.addSubview(titleView)
        view.addSubview(tableView)
        view.addSubview(loginButton)
        view.addSubview(spinner)
        
        user()
        setupUI()
        configureTableView()
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = UserDefaults.standard.value(forKey: "userID") != nil
    }
    
    @objc private func logoutButtonTapped() {
        UserDefaults.standard.setValue(nil, forKey: "token")
        UserDefaults.standard.setValue(nil, forKey: "userID")
        titleView.isHidden = true
        tableView.isHidden = true
        loginButton.isHidden = false
        navigationController?.isNavigationBarHidden = false
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let statusBarFrame = windowScene.statusBarManager?.statusBarFrame {
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.backgroundColor = .systemBackground
                view.addSubview(statusBarView)
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    private func setupUI(){
        titleView.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.height.equalTo(70)
        }
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        logoutButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        textStackView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(logoutButton.snp.left).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
        nameLabel.snp.makeConstraints { $0.left.right.top.equalToSuperview() }
        emailLabel.snp.makeConstraints { $0.left.right.bottom.equalToSuperview() }
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
        }
        loginButton.snp.makeConstraints({$0.center.equalToSuperview()})
    }
    
    private func user() {
        if let userID = UserDefaults.standard.value(forKey: "userID") as? Int {
            viewModel.user(sessionDelegate: self, userID: userID) {[weak self] isError, errorString in
                if isError {
                    self?.showAlert(title: "Error", message: errorString)
                }
                else {
                    self?.nameLabel.text = "\(self?.viewModel.user?.firstName ?? "") \(self?.viewModel.user?.lastName ?? "")"
                    self?.emailLabel.text = "\(self?.viewModel.user?.email ?? "")"
                    self?.tableView.isHidden = false
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let statusBarFrame = windowScene.statusBarManager?.statusBarFrame {
                            let statusBarView = UIView(frame: statusBarFrame)
                            statusBarView.backgroundColor = UIColor(red: 0.13, green: 0.83, blue: 0.71, alpha: 1)
                            self?.view.addSubview(statusBarView)
                            self?.titleView.isHidden = false
                            self?.titleView.snp.makeConstraints({ $0.top.equalToSuperview().offset(statusBarFrame.height) })
                        }
                    }
                    
                    guard let url = URL(string: self?.viewModel.user?.image ?? "") else { return }
                    self?.profileImageView.download(from: url, sessionDelegate: self) {}
                }
                self?.spinner.stopAnimating()
            }
        }
        else {
            loginButton.isHidden = false
            spinner.stopAnimating()
        }
    }
    
}
