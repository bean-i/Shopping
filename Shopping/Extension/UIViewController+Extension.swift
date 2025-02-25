//
//  UIViewController+Extension.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default)
        
        alert.addAction(button)
        
        self.present(alert, animated: true)
    }
    
}
