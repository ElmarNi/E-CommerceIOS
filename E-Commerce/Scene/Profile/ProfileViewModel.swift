//
//  ProfileViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 01.02.24.
//

import Foundation

final class ProfileViewModel {
    enum Section {
        case personalInformation(data: [String])
        case supportAndInformation(data: [String])
        case accountManagment(data: [String])
        
        var title: String {
            switch self {
            case .personalInformation:
                return "Personal Information"
            case .supportAndInformation:
                return "Support & Information"
            case .accountManagment:
                return "Account Management"
            }
        }
    }
    var sections = [Section]()
    
    init() {
        sections.append(.personalInformation(data: ["Shipping Address", "Payment Method"]))
        sections.append(.supportAndInformation(data: ["Privacy Policy", "Terms & Conditions", "FAQs"]))
        sections.append(.accountManagment(data: ["Change Password"]))
    }
    
    var user: User? = nil
    
    func user(sessionDelegate: URLSessionDelegate?, userID: Int, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: User.self,
                                          url: "users/\(userID)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.user = result
                    completion(false, nil)
                default:
                    completion(true, "Can't get user")
                }
            }
        }
    }
    
}
