//
//  Filter.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 24.01.24.
//

import Foundation

enum Filter: Int {
    case priceLToH
    case priceHtoL
    case aToZ
    case zToA
    
    var title: String {
        switch self {
        case .priceLToH:
            return "Price (Low to High)"
        case .priceHtoL:
            return "Price (High to Low)"
        case .aToZ:
            return "A-Z"
        case .zToA:
            return "Z-A"
        }
    }
    
    static func titleAtIndex(index: Int) -> String? {
        guard let filter = Filter(rawValue: index) else {
            return nil
        }
        return filter.title
    }
}
