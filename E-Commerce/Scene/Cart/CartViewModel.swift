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
                    completion(true, "Can't get cart", nil)
                }
            }
        }
    }
    
    func updateCart(sessionDelegate: URLSessionDelegate?, cartId: Int, products: [CartProduct], completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        
        let requestBody: [String: Any] = [
            "products": products.map { product in
                return [
                    "id": product.id,
                    "title": product.title,
                    "quantity": product.quantity,
                    "total": product.total,
                    "price": product.price,
                    "thumbnail": product.thumbnail
                ]
            },
            "merge": false
        ]
        
        DispatchQueue.main.async {
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: requestBody,
                                          type: Cart.self,
                                          url: "carts/\(cartId)",
                                          method: .PUT)
            { response in
                switch response {
                case .success(let result):
                    completion(false, nil)
                default:
                    completion(true, "Can't delete this product from cart, please try again")
                }
            }
        }
    }
    
}
