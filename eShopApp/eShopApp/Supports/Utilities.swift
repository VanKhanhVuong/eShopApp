//
//  Utilities.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import Foundation
import KeychainAccess

enum optionKeychain: String {
    case getUserId, saveUserId = "userId"
    case getEmailUser, saveEmail = "email"
}

class Utilities {
    let keychain = Keychain()
    
    func getUserId() -> String {
        let userId = keychain[optionKeychain.getUserId.rawValue] ?? ""
        if !userId.isEmpty {
            return userId
        } else {
            return "Sorry don`t get UserId"
        }
    }
    
    func getEmailUser() -> String {
        let emailUser = keychain["email"] ?? ""
        if !emailUser.isEmpty {
            return emailUser
        } else {
            return "Sorry don`t get emailUser"
        }
    }
    
    func saveUserId(_ userId: String) -> Bool {
        do {
            try keychain.set(userId, key: optionKeychain.saveUserId.rawValue)
            return true
        }
        catch let error {
            print(error)
            return false
        }
    }
    
    func saveEmail(_ email: String) -> Bool {
        do {
            try keychain.set(email, key: optionKeychain.saveEmail.rawValue)
            return true
        }
        catch let error {
            print(error)
            return false
        }
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return passwordPredicate.evaluate(with: password)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
