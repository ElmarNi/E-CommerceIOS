//
//  SignUpViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation

final class SignUpViewModel {
    func register(sessionDelegate: URLSessionDelegate?, username: String, password: String, fullname: String, completion: @escaping (Bool) -> Void) {
        let requestBody: [String: Any] = [
            "username": username,
            "password": password,
            "firstName": String(fullname.split(separator: " ").first ?? ""),
            "lastName": String(fullname.split(separator: " ").last ?? "")
        ]
        
        NetworkManager.shared.request(sessionDelegate: sessionDelegate, requestBody: requestBody,
                                      type: SignUp.self,
                                      url: "users/add",
                                      method: .POST)
        { response in
            switch response {
            case .success(_): completion(true)
            default: completion(false)
            }
        }
    }
}
