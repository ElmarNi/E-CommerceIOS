
import Foundation

final class LoginViewModel {
    func login(sessionDelegate: URLSessionDelegate?, username: String, password: String, completion: @escaping (Bool) -> Void) {
        let requestBody: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        NetworkManager.shared.request(sessionDelegate: sessionDelegate, 
                                      requestBody: requestBody,
                                      type: Login.self,
                                      url: "auth/login",
                                      method: .POST)
        { response in
            switch response {
            case .success(let result):
                UserDefaults.standard.setValue(result.token, forKey: "token")
                UserDefaults.standard.setValue(result.id, forKey: "userID")
                
                completion(true)
            default: completion(false)
            }
        }
    }
}
