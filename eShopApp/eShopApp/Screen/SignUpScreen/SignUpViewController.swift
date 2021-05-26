//
//  SignUpViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var messageSignUpView: CustomView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSignUpView.titleLabel.text = "Sign Up"
        messageSignUpView.subtitleLabel.text = "Enter your credentials to continue"
        setupView()
    }
    
    func setupView() {
    }
    
    func validateField() -> String? {
        // Check that all fields are filled in
        if (userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields."
        }
        // Check if the password is secure
        guard let validPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        if Utilities.isPasswordValid(validPassword) == false {
            return "Please make sure your password is at least 8 characters, 1 Uppercase alphabet, 1 Lowercase alphabet and 1 Number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        // Validate the fields
        let error = validateField()
        if error != nil {
            // Show message Error
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    print("Sign up Fail")
                } else {
                    print("Sign up Success")
                }
            }
        }
    }
}
