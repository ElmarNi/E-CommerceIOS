//
//  ShippingViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 09.02.24.
//

import Foundation

final class ShippingViewModel {
    var address: Address?
    
    func user(sessionDelegate: URLSessionDelegate?, userID: Int, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: User.self,
                                          url: "users/\(userID)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.address = result.address
                    completion(false, nil)
                default:
                    completion(true, "Can't get user")
                }
            }
        }
    }
    
    func update(sessionDelegate: URLSessionDelegate?, userID: Int, address: Address, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        
        let requestBody: [String: Any] = [
            "address": [
                "address": address.address,
                "city": address.city,
                "postalCode": address.postalCode
            ]
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
                    completion(false, "Address succesfully changed")
                default:
                    completion(true, "Can't change address, please try again")
                }
            }
        }
    }
}
