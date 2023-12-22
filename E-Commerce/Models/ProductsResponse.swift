//
//  ProductsResponse.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation

struct ProductsResponse:Codable {
    let limit: Int
    let products: [Product]
    let skip: Int
    let total: Int
}
