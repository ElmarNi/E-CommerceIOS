//
//  NetworkManager.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation



final class NetworkManager {
    static let shared = NetworkManager()
    
    enum METHOD: String {
        case GET
        case POST
        case PUT
    }
    
    enum ErrorType: String, Error {
        case error = "ERROR"
    }
    
    func request<T:Codable> (sessionDelegate: URLSessionDelegate?,
                             requestBody: [String:Any]?,
                             type: T.Type,
                             url: String,
                             method: METHOD,
                             completion: @escaping(Result<T, ErrorType>) -> Void)
    {
        guard let url = URL(string: "https://dummyjson.com/\(url)") else {
            return completion(.failure(.error))
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let requestBody = requestBody {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.error))
                return
            }
        }
        URLSession(
            configuration: .default,
            delegate: sessionDelegate ?? .none,
            delegateQueue: OperationQueue.main).dataTask(with: request)
        { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.error))
                return
            }
            self.handleResponse(data: data) { response in
                completion(response)
            }
            
        }.resume()
    }
    
    private func handleResponse<T: Codable> (data: Data, completion: @escaping (Result<T, ErrorType>) -> Void) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        }
        catch {
            completion(.failure(.error))
        }
    }
}
