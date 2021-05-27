//
//  String+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 27/05/2021.
//

import Foundation

extension String {
    func isPasswordValid(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return passwordPredicate.evaluate(with: password)
    }
}
