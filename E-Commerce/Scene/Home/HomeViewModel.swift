//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation

final class HomeViewModel {
    enum Section {
        case topProducts(data: [Product])
        case categories(data: [String])
        case latestProducts(data: [Product])
    }
    
    var sections = [Section]()
    
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
                default: completion(nil)
                }
            }
        }
    }
    
    func topProducts(sessionDelegate: URLSessionDelegate?, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: ProductsResponse.self,
                                      url: "products?limit=10",
                                      method: .GET)
        {[weak self] response in
            switch response {
            case .success(let result):
                self?.sections.append(.topProducts(data: result.products))
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    func categories(sessionDelegate: URLSessionDelegate?, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: [String].self,
                                      url: "products/categories",
                                      method: .GET)
        {[weak self] response in
            switch response {
            case .success(let result):
                self?.sections.append(.categories(data: result))
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    func latestProducts(sessionDelegate: URLSessionDelegate?, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: ProductsResponse.self,
                                      url: "products?limit=40&skip=10",
                                      method: .GET)
        {[weak self] response in
            switch response {
            case .success(let result):
                self?.sections.append(.latestProducts(data: result.products))
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
}

