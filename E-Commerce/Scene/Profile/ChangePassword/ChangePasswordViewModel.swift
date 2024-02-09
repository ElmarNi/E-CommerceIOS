//
//  ChangePasswordViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import Foundation

final class ChangePasswordViewModel {
    func changePassword(sessionDelegate: URLSessionDelegate?, userID: Int, password: String, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        
        let requestBody: [String: Any] = [
            "password": password
        ]
        
        DispatchQueue.main.async {
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: requestBody,
                                          type: User.self,
                                          url: "users/\(userID)",
                                          method: .PUT)
            { response in
                switch response {
                case .success(_):
                    completion(false, "Password succesfully changed")
                default:
                    completion(true, "Can't change password, please try again")
                }
            }
        }
    }
}
