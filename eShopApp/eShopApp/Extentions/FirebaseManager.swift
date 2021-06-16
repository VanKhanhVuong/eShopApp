//
//  FirebaseManager.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 16/06/2021.
//

import Foundation
import FirebaseAuth
import FirebaseCore

class ManagerFirebase {
    func getVerificationIdPhone(numberPhone: String) -> String {
        var verificationId: String = ""
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(numberPhone, uiDelegate: nil) { verificationID, error in
            if (error != nil){
                print(error.debugDescription)
                verificationId = "Error getting verification id code"
            } else {
                verificationId = verificationID ?? ""
            }
        }
        return verificationId
    }
    
    func signInWithPhoneNumber(vetificationText: String, verificationID: String) -> String {
        var signInWithPhone: String = ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: vetificationText)
        Auth.auth().signIn(with: credential) { authData, error in
            if (error != nil){
                print(error.debugDescription)
                signInWithPhone = "Can't find phone number error"
            } else {
                signInWithPhone = "Signed in with phone successfully"
            }
        }
        return signInWithPhone
    }
    
    func signInWithEmail(email: String, password: String) -> String {
        var signInWithEmail: String = ""
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                signInWithEmail = "Unable to login account error"
            } else {
                signInWithEmail = "Signed in with email successfully"
            }
        }
        return signInWithEmail
    }
    
    func getUid() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func createUser(email: String, password: String) -> String {
        var createUser: String = ""
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                createUser = "Error can't create account"
            } else {
                createUser = "Account successfully created"
            }
        }
        return createUser
    }
}
