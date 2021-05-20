//
//  NumberViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 19/05/2021.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@available(iOS 13.0, *)
class NumberViewController: UIViewController {
    @IBOutlet weak var vetificationButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var vetificationId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func vetificationNumberPhone(_ sender: Any) {
        guard let number: String = phoneNumberTextField.text else { return }
        if !number.isEmpty {
            authPhone(numberPhone: "+84" + number)
        } else {
            showAlert(message: "Please enter your phone number")
        }
    }
    
    func authPhone(numberPhone: String) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(numberPhone, uiDelegate: nil) { verificationID, error in
            if (error != nil){
                self.showAlert(message: "Sorry, the process of verifying phone number " +  numberPhone + " is faulty")
            } else {
                self.vetificationId = verificationID ?? ""
                self.navigationVerificationView(numberPhone: numberPhone)
            }
        }
    }
    
    func showAlertErrorGetVerificationID() {
        let alert = UIAlertController(title: "Message !!!", message: "Sorry don't", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigationVerificationView(numberPhone: String) {
        if !vetificationId.isEmpty {
            let storyBoard = UIStoryboard(name: "Verification", bundle: nil)
            guard let verificationView = storyBoard.instantiateViewController(identifier: "VerificationView") as? VerificationViewController else { return }
            verificationView.numberPhone = numberPhone
            verificationView.verificationID = vetificationId
            self.navigationController?.pushViewController(verificationView, animated: true)
        } else {
            // Error Firebase return verificationID = nil
            showAlert(message: "Sorry the authentication failed, please try again later.")
        }
    }
}
