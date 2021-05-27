//
//  LoginViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var messageLoginView: CustomView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        messageLoginView.titleLabel.text = "Loging"
        messageLoginView.subtitleLabel.text = "Enter your emails and password"
    }
    
    func validateField() -> String? {
        if (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields."
        }
        
        guard let validPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        if Utilities.isPasswordValid(validPassword) == false {
            return "Please make sure your password is at least 8 characters, 1 Uppercase alphabet, 1 Lowercase alphabet and 1 Number."
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        let error = validateField()
        if error != nil {
            // Show message Error
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    print("Sign in Fail")
                } else {
                    print("Sign in Success")
                }
            }
        }
    }
}
