//
//  Cart.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 27.01.24.
//

import Foundation

struct Cart: Codable {
    let id: Int
    let products: [CartProduct]
    let total: Double
    let discountedTotal: Double
    let userId: Int
    let totalProducts: Int
    let totalQuantity: Int
}
