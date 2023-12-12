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
    
    public func login(sessionDelegate: URLSessionDelegate, username: String, password: String, completion: @escaping (Bool) -> Void) {
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
            
            URLSession(
                configuration: .default,
                delegate: sessionDelegate,
                delegateQueue: OperationQueue.main).dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(false)
                        return
                    }
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let token = jsonResponse?["token"] as? String,
                           let id = jsonResponse?["id"] as? Int {
                            UserDefaults.standard.setValue(token, forKey: "token")
                            UserDefaults.standard.setValue(id, forKey: "userID")
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                    catch {
                        print(error)
                        completion(false)
                    }
                }.resume()
        }
    }
    
    public func register(sessionDelegate: URLSessionDelegate, username: String, password: String, fullname: String, completion: @escaping (Bool) -> Void) {
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
            
            URLSession(
                configuration: .default,
                delegate: sessionDelegate,
                delegateQueue: OperationQueue.main).dataTask(with: request) { data, _, error in
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
    
    public func getUser(sessionDelegate: URLSessionDelegate, userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        createRequest(url: "https://dummyjson.com/users/\(userId)", method: .GET) { request in
            URLSession(
                configuration: .default,
                delegate: sessionDelegate,
                delegateQueue: OperationQueue.main).dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(NSError()))
                        return
                    }
                    
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                    }
                    catch {
                        completion(.failure(NSError()))
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
