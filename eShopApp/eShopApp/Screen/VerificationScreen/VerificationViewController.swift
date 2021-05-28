//
//  VerificationViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 19/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseCore

@available(iOS 13.0, *)
class VerificationViewController: UIViewController {
    @IBOutlet weak var backToHomeButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var vetificationTextField: UITextField!
    @IBOutlet weak var numberPhoneLabel: UILabel!
    @IBOutlet weak var backToNumberButton: UIButton!
    
    var numberPhone: String = ""
    var verificationID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func submitCode(_ sender: Any) {
        verificationPhoneNumber()
    }
    
    @IBAction func resendClick(_ sender: Any) {
        self.vetificationTextField.text = ""
        self.vetificationTextField.isHidden = true
        authPhone(numberPhone: self.numberPhone)
    }
    
    @IBAction func backToNumberTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        numberPhoneLabel.text = "Your phone number : " + numberPhone
        backToHomeButton.clipsToBounds = true
        backToHomeButton.layer.cornerRadius = backToHomeButton.bounds.size.height/2
    }
    
    func authPhone(numberPhone: String) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(numberPhone, uiDelegate: nil) { verificationID, error in
            if (error != nil){
                self.showAlert(message: "ERROR IN GETTING VERIFICATION ID")
            } else {
                self.vetificationTextField.isHidden = false
                self.verificationID = verificationID ?? ""
            }
        }
    }
    
    func navigationHomeView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        guard let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as? MainViewController else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true, completion: nil)
    }
    
    func verificationPhoneNumber() {
        guard let vetificationText: String = vetificationTextField.text  else { return }
        if !vetificationText.isEmpty {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: vetificationText)
            Auth.auth().signIn(with: credential) { authData, error in
                if (error != nil){
                    print(error.debugDescription)
                } else {
                    self.navigationHomeView()
                }
            }
        } else {
            showAlert(message: "Show alert input verificationCode")
        }
    }
}
