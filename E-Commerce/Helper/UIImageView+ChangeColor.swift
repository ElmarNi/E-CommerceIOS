//
//  UIImageView+ChangeColor.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 16.02.24.
//

import Foundation
import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
