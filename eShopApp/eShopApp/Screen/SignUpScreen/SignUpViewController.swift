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
    @IBOutlet weak var signInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSignUpView.titleLabel.text = "Sign Up"
        messageSignUpView.subtitleLabel.text = "Enter your credentials to continue"
        setupView()
        actionClickSignUp()
    }
    
    func actionClickSignUp() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.navigationSignInScreen))
        self.signInLabel.addGestureRecognizer(gesture)
    }
    
    @objc func navigationSignInScreen(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        signUpButton.configureButton()
        signInLabel.attributedText = changeColorText()
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
        myMutableString = NSMutableAttributedString(string: "Already have an account? Login" as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: CGFloat(14.0)) as Any])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AccentColor") ?? "", range: NSRange(location:25, length: 5))
        return myMutableString
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if !Utilities.isValidEmail(email) {
            showAlert(message: "Please enter the correct email format.")
        }
    
        // Validate the fields
        let error = validateField()
        if error != nil {
            self.showAlert(message: error ?? "")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    self.showAlert(message: "Create account fail")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
