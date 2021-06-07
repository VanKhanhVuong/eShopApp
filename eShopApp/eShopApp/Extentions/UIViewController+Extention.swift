//
//  UIViewController+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import UIKit
import KeychainAccess

extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Message !!!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getUserId() -> String {
        let keychain = Keychain()
        let userId = keychain["token"] ?? ""
        return userId
    }
}
