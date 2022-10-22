//
//  UIView+Loader.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showProgress() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    func showAlertMessage(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
        return alert
    }
    
    func showAlertTextfield(title: String, message: String, mode: CurrencyManager.mode) -> UIAlertController {
        var textField = UITextField()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.textAlignment = .center
            alertTextField.placeholder = "Code"
            textField = alertTextField
        }
        if mode == CurrencyManager.mode.add {
            let action = UIAlertAction(title: "Add", style: .default) { action in
                if textField.text != "" && textField.text?.count == 3 {
                    let temp = textField.text!.uppercased()
                    self.showAlertMessage(title: "", message: CurrencyManager.AddCurrency(currency: temp))
                }
            }
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
        return alert
    }
    
}

extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
    }
    
}
