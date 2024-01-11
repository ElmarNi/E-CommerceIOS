//
//  CategoriesViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 10.01.24.
//

import Foundation

final class CategoriesViewModel {
    private var categories = [String]()
    
    func categories(sessionDelegate: URLSessionDelegate?, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: [String].self,
                                          url: "products/categories",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self.categories = result
                    completion(true, nil)
                default:
                    completion(false, "Can't get categories")
                }
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        return categories.count
    }
    
    func getCategory(index: Int) -> String{
        return categories[index]
    }
}
