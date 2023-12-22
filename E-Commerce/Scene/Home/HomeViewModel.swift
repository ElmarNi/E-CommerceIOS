//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation

final class HomeViewModel {
    func userImage(sessionDelegate: URLSessionDelegate?, completion: @escaping (URL?) -> Void) {
        let userID = UserDefaults.standard.value(forKey: "userID") as? Int ?? -1
        if userID != -1 {
            NetworkManager.shared.request(sessionDelegate: sessionDelegate, requestBody: nil,
                                          type: User.self,
                                          url: "users/\(userID)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let user):
                    guard let url = URL(string: user.image)
                    else {
                        return completion(nil)
                    }
                    completion(url)
                case .failure(_): completion(nil)
                }
            }
        }
    }
}

