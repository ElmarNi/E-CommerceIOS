//
//  HomeViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoTitleView())
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: nil, action: nil)]
        getUserImage()
        
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getUserImage() {
        let userID = UserDefaults.standard.value(forKey: "userID") as? Int ?? -1
        
        if userID != -1 {
            let imageView = UIImageView()
            DispatchQueue.main.async {
                ApiCaller.shared.getUser(sessionDelegate: self, userId: userID) {[weak self] result in
                    switch result {
                    case .success(let user):
                        let imageView = UIImageView()
                        guard let url = URL(string: user.image),
                              let self = self
                        else { return }
                        
                        imageView.download(from: url, sessionDelegate: self)
                        break
                    case .failure(_):
                        self?.showAlert(title: "Error", message: "Can't get user's data")
                    }
                }
            }
        }
    }
}
