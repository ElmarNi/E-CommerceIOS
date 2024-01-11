//
//  UIStackView+Curved.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 08.01.24.
//

import Foundation
import UIKit

class CurvedStackView: UIStackView {
//    private var curvature: CGFloat
//    init(curvature: CGFloat) {
//        self.curvature = curvature
//        super.init(frame: .zero)
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftCurvature: CGFloat = 20.0
        let rightCurvature: CGFloat = 20.0
        
        // Create a UIBezierPath for the left side curve
        let leftPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: leftCurvature, height: leftCurvature))
        
        // Create a UIBezierPath for the right side curve
        let rightPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: rightCurvature, height: rightCurvature))
        
        // Append the right path to the left path
        leftPath.append(rightPath)
        
        // Create a CAShapeLayer with the combined path
        let maskLayer = CAShapeLayer()
        maskLayer.path = leftPath.cgPath
        
        // Apply the mask to the stack view
        layer.mask = maskLayer
    }
}
