//
//  VerificationViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 19/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class VerificationViewController: UIViewController {
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var vetificationTextField: UITextField!
    @IBOutlet weak var numberPhoneLabel: UILabel!
    var numberPhone: String = ""
    var verificationID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        numberPhoneLabel.text = "Your phone number : " + numberPhone
    }
    
    @IBAction func submitCode(_ sender: Any) {
        verificationPhoneNumber()
    }
    
    @IBAction func resendClick(_ sender: Any) {
        self.vetificationTextField.text = ""
        self.vetificationTextField.isHidden = true
        authPhone(numberPhone: self.numberPhone)
    }
    
    func authPhone(numberPhone: String) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(numberPhone, uiDelegate: nil) { verificationID, error in
            if (error != nil){
                self.showAlert(message: "Show arlert ERROR IN GETTING VERIFICATION ID")
            } else {
                self.vetificationTextField.isHidden = false
                self.verificationID = verificationID ?? ""
                print("Show message has sent a request for re-issuance of the code, please enter VERIFICATION CODE")
            }
        }
    }
    
    func verificationPhoneNumber() {
        guard let vetificationText: String = vetificationTextField.text  else { return }
        if !vetificationText.isEmpty {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: vetificationText)
            Auth.auth().signIn(with: credential) { authData, error in
                if (error != nil){
                    print(error.debugDescription)
                } else {
                    print("Auth Success")
                }
            }
        } else {
            showAlert(message: "Show alert input verificationCode")
        }
    }
}
