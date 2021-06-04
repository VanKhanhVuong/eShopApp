//
//  SignUpViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import UIKit
import FirebaseAuth

protocol SignUpViewEvents: AnyObject {
    func signUpSuccess()
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var messageSignUpView: CustomView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInLabel: UILabel!
    
    var delegate: SignUpViewEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSignUpView.titleLabel.text = "Sign Up"
        messageSignUpView.subtitleLabel.text = "Enter your credentials to continue"
        setupView()
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
                    self.delegate?.signUpSuccess()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func setupView() {
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 15
        
//        signInLabel.attributedText = changeColorText()
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
    
    private func changeColorText() -> NSMutableAttributedString {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "Already have an account? Sign In" as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: CGFloat(14.0)) as Any])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:26, length: 7))
        return myMutableString
    }
}
