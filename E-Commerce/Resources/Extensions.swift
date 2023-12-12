//
//  Extensions.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

//MARK: trust connection for apis
extension UIViewController: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

extension UIView: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

//MARK: download image from url
extension UIImageView {
    func download(from url: URL, sessionDelegate: URLSessionDelegate, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: sessionDelegate,
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

//MARK: common alert
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension UIView {
    func showAlert(title: String, message: String) {
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.showAlert(title: title, message: message)
        }
    }
}
