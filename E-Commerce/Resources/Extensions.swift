//
//  Extensions.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 04.12.23.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
