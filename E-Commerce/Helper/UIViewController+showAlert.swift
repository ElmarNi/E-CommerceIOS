//
//  UIViewController+showAlert.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.12.23.
//

import Foundation
import UIKit



extension UIViewController {
    func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
