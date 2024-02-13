//
//  User.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 08.12.23.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let image: String
    let email: String
    let address: Address
}
