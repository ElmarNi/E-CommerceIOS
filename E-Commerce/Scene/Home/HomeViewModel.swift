//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation

final class HomeViewModel {
    enum Section {
        case categories(data: [String])
        case latestProducts(data: [Product])
        case topProducts(data: [Product])
        var title: String {
            switch self {
            case .categories:
                return "Categories"
            case .latestProducts:
                return "Latest Products"
            default:
                return ""
            }
        }
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
    
    func topProducts(sessionDelegate: URLSessionDelegate?, completion: @escaping ([Product]?) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: ProductsResponse.self,
                                      url: "products?limit=5",
                                      method: .GET)
        { response in
            switch response {
            case .success(let result):
                completion(result.products)
            default:
                completion(nil)
            }
        }
    }
    
    func categories(sessionDelegate: URLSessionDelegate?, completion: @escaping ([String]?) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: [String].self,
                                      url: "products/categories",
                                      method: .GET)
        { response in
            switch response {
            case .success(let result):
                completion(result)
            default:
                completion(nil)
            }
        }
    }
    
    func latestProducts(sessionDelegate: URLSessionDelegate?, completion: @escaping ([Product]?) -> Void) {
        NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                      requestBody: nil,
                                      type: ProductsResponse.self,
                                      url: "products?limit=40&skip=5",
                                      method: .GET)
        { response in
            switch response {
            case .success(let result):
                completion(result.products)
            default:
                completion(nil)
            }
        }
    }
    
}
