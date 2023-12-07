//
//  ApiCaller.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 06.12.23.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    enum METHOD: String {
        case GET
        case POST
    }
    
    public func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        createRequest(url: "https://dummyjson.com/auth/login", method: .POST) { baseRequest in
            var request = baseRequest
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let requestBody: [String: Any] = [
                "username": username,
                "password": password
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(false)
                return
            }
            
            URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main).dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let token = jsonResponse?["token"] as? String {
                        UserDefaults.standard.setValue(token, forKey: "token")
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                catch {
                    completion(false)
                }
            }.resume()
        }
    }
    
    public func register(username: String, password: String, fullname: String, completion: @escaping (Bool) -> Void) {
        createRequest(url: "https://dummyjson.com/users/add", method: .POST) { baseRequest in
            var request = baseRequest
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let requestBody: [String: Any] = [
                "username": username,
                "password": password,
                "firstName": String(fullname.split(separator: " ").first ?? ""),
                "lastName": String(fullname.split(separator: " ").last ?? "")
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(false)
                return
            }
            
            URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main).dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let id = jsonResponse?["id"] as? Int {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                catch {
                    completion(false)
                }
            }.resume()
        }
    }
    
    private func createRequest(url: String, method: METHOD, completion: @escaping (URLRequest) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        completion(request)
    }
}
