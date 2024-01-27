//
//  CartResponse.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import Foundation

struct CartResponse: Codable {
    let carts: [Cart]
    let total: Int
    let skip: Int
    let limit: Int
}
