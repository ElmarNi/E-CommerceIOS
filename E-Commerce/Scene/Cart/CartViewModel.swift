//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import Foundation

final class CartViewModel {
    var cart: Cart?
    
    func carts(sessionDelegate: URLSessionDelegate?, userId: Int, completion: @escaping (_ isError: Bool, _ errorString: String?, _ isCartEmpty: Bool?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: CartResponse.self,
                                          url: "carts/user/\(userId)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.cart = result.carts.first
                    completion(false, nil, self?.cart == nil)
                default:
                    completion(true, "Can't get products", nil)
                }
            }
        }
    }
    
}
