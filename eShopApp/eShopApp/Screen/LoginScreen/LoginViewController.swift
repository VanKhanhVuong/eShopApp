//
//  LoginViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import UIKit
import FirebaseAuth

protocol LoginViewEvents: AnyObject {
    func loginSuccess()
}

class LoginViewController: UIViewController {
    @IBOutlet weak var messageLoginView: CustomView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var closeScreenButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    var delegate: LoginViewEvents?
    private let utilities = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func actionClickSignUp() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.navigationSignUpScreen))
        self.signUpLabel.addGestureRecognizer(gesture)
    }
    
    @objc func navigationSignUpScreen(sender : UITapGestureRecognizer) {
        let mainStoryboard = UIStoryboard(name: "SignUp", bundle: .main)
        guard let signUpViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignUpView") as? SignUpViewController else { return }
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    func navigationHomeScreen(emailUser: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let (resultEmail, errorEmail) = utilities.saveEmail(emailUser)
        let (resultUser, errorUser) = utilities.saveUserId(userID)
        if (errorEmail != nil) || (errorUser != nil) {
            showAlert(message: "Cannot get user information")
        } else {
            print(resultEmail)
            print(resultUser)
        }
    }
    
    private func changeColorText() -> NSMutableAttributedString {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "Don’t have an account? Singup" as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Gilroy-Bold", size: CGFloat(14.0)) as Any])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AccentColor") ?? "", range: NSRange(location:23, length: 6))
        return myMutableString
    }
    
    func setupView() {
        actionClickSignUp()
        self.signUpLabel.attributedText = changeColorText()
        
        messageLoginView.titleLabel.text = "Loging"
        messageLoginView.subtitleLabel.text = "Enter your emails and password"
        
        loginButton.configureButton()
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
    
    @IBAction func closeScreenTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
                    self.navigationHomeScreen(emailUser: email)
                }
            }
        }
    }
}
