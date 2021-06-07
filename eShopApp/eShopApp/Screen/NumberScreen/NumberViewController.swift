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
    @IBOutlet weak var backButton: UIButton!
    
    var vetificationId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func vetificationNumberPhone(_ sender: Any) {
        guard let number: String = phoneNumberTextField.text else { return }
        if !number.isEmpty {
            authPhone(numberPhone: "+84" + number)
        } else {
            showAlert(message: "Please enter your phone number")
        }
    }
    @IBAction func backSignInTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        vetificationButton.clipsToBounds = true
        vetificationButton.layer.cornerRadius = vetificationButton.bounds.size.height/2
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
            let mainStoryboard = UIStoryboard(name: "Verification", bundle: .main)
            guard let verificationViewController = mainStoryboard.instantiateViewController(withIdentifier: "VerificationView") as? VerificationViewController else { return }
            verificationViewController.modalPresentationStyle = .fullScreen
            verificationViewController.numberPhone = numberPhone
            verificationViewController.verificationID = vetificationId
            present(verificationViewController, animated: true, completion: nil)
        } else {
            // Error Firebase return verificationID = nil
            showAlert(message: "Sorry the authentication failed, please try again later.")
        }
    }
}
