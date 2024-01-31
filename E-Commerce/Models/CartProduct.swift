//
//  CartProduct.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import Foundation

struct CartProduct: Codable {
    let id: Int
    let title: String?
    var quantity: Int
    var total: Float?
    let price: Float?
    let thumbnail: String?
}
