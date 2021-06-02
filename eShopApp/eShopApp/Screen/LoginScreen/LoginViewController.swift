//
//  LoginViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import UIKit
import FirebaseAuth
import KeychainAccess

class LoginViewController: UIViewController {
    @IBOutlet weak var messageLoginView: CustomView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        let error = validateField()
        if error != nil {
            self.showAlert(message: error ?? "")
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    self.showAlert(message: "Login Fail !")
                } else {
                    self.navigationHomeScreen()
                }
            }
        }
    }
    
    func navigationHomeScreen() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let keychain = Keychain()
        keychain[string: "token"] = userID
        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
//        guard let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as? MainViewController else { return }
//        mainViewController.modalPresentationStyle = .fullScreen
//        present(mainViewController, animated: true, completion: nil)
    }
    
    func setupView() {
        messageLoginView.titleLabel.text = "Loging"
        messageLoginView.subtitleLabel.text = "Enter your emails and password"
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 15
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
}
