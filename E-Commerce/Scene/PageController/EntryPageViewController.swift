//
//  EntryPageViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 05.12.23.
//

import UIKit

protocol EntryPageViewControllerDelegate: AnyObject {
    func nextButtonTapped(index: Int) -> Void
}

class EntryPageViewController: UIViewController {
    
    weak var delegate: EntryPageViewControllerDelegate?
    private let data = [EntryPage]()
    
    private let mainFrame = UIView()
    
    private let bgLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.959, green: 0.992, blue: 0.982, alpha: 1)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let skipButton = CyanButton(title: "Skip for now")
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.44, green: 0.45, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: 14)
        return label
    }()
    
    private let nextButton = RoundedBlackButton(title: "Next")
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        return button
    }()
    
    private let getStartedButton = RoundedBlackButton(title: "Get Started")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgLayer.addSubview(logoImageView)
        bgLayer.addSubview(skipButton)
        bgLayer.addSubview(iconImageView)
        mainFrame.addSubview(bgLayer)
        mainFrame.addSubview(titleLabel)
        mainFrame.addSubview(descriptionLabel)
        mainFrame.addSubview(nextButton)
        mainFrame.addSubview(loginButton)
        mainFrame.addSubview(getStartedButton)
        view.addSubview(mainFrame)
        setupUI()
        
        skipButton.addTarget(self, action: #selector(pushTabBarController), for: .touchUpInside)
        getStartedButton.addTarget(self, action: #selector(pushTabBarController), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func pushTabBarController() {
        UserDefaults.standard.setValue(true, forKey: "isLaunched")
        navigationController?.viewControllers = [TabBarController()]
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        delegate?.nextButtonTapped(index: sender.tag)
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    private func setupUI() {
        mainFrame.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
        
        bgLayer.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(408)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.height.equalTo(32)
            make.width.equalTo(104)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(32)
            make.width.equalTo(104)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(skipButton.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bgLayer.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).inset(4)
            make.height.equalTo(60)
        }
        
        getStartedButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).inset(4)
            make.height.equalTo(60)
        }
    }
    
    func configure(data: EntryPage, index: Int) {
        iconImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        nextButton.isHidden = data.isLogin
        loginButton.isHidden = !data.isLogin
        getStartedButton.isHidden = !data.isLogin
        nextButton.tag = index
    }

}
