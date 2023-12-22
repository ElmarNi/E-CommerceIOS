//
//  UIImageView+download.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation
import UIKit

extension UIImageView {
    func download(from url: URL, sessionDelegate: URLSessionDelegate?, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: sessionDelegate ?? .none,
                delegateQueue: OperationQueue.main).dataTask(with: url)
            { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else {
                    self.image = UIImage(named: "no-image")
                    completion?()
                    return
                }
                self.image = image
                completion?()
            }.resume()
        }
    }
}
