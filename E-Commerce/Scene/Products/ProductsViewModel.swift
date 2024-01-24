//
//  ProductsViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 12.01.24.
//

import Foundation

final class ProductsViewModel {
    private var products = [Product]()
    
    func byCategory(sessionDelegate: URLSessionDelegate?, category: String, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate, 
                                          requestBody: nil,
                                          type: ProductsResponse.self,
                                          url: "products/category/\(category)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.products = result.products
                    completion(false, nil)
                default:
                    completion(true, "Can't get products")
                }
            }
        }
    }
    
    func byQuery(sessionDelegate: URLSessionDelegate?, query: String, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: ProductsResponse.self,
                                          url: "products/search?q=\(query)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.products = result.products
                    completion(false, nil)
                default:
                    completion(true, "Can't get products")
                }
            }
        }
    }
    
    func latestProducts(sessionDelegate: URLSessionDelegate?, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: ProductsResponse.self,
                                          url: "products?limit=200&skip=5",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.products = result.products
                    completion(false, nil)
                default:
                    completion(true, "Can't get products")
                }
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return products.count
    }
    
    func getProduct(index: Int) -> Product {
        return products[index]
    }
    
    func filterProducts(_ filter: Filter?, completion: @escaping () -> Void) {
        guard let filter = filter else { return }
        switch filter {
        case .priceHtoL:
            products = products.sorted { $0.price > $1.price }
        case .aToZ:
            products = products.sorted { $0.title < $1.title }
        case .zToA:
            products = products.sorted { $0.title > $1.title }
        case .priceLToH:
            products = products.sorted { $0.price < $1.price }
        }
        completion()
    }
    
}
