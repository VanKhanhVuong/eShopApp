//
//  SignUpViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 19/05/2021.
//

import UIKit

@available(iOS 13.0, *)
class SignInViewController: UIViewController {
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var closeSignButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @IBAction func closeSignScreenTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        actionClickShowDetail()
        actionClickLoginLabel()
    }
    
    func actionClickShowDetail() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.inputNumberPhone))
        self.phoneNumberView.addGestureRecognizer(gesture)
    }
    
    @objc func inputNumberPhone(sender : UITapGestureRecognizer) {
        let mainStoryboard = UIStoryboard(name: "Number", bundle: .main)
        guard let numberViewController = mainStoryboard.instantiateViewController(withIdentifier: "NumberView") as? NumberViewController else { return }
        numberViewController.modalPresentationStyle = .fullScreen
        present(numberViewController, animated: true, completion: nil)
    }
    
    func actionClickLoginLabel() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.login))
        self.loginLabel.addGestureRecognizer(gesture)
    }
    
    @objc func login(sender : UITapGestureRecognizer) {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: .main)
        guard let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else { return }
        loginViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc func close(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
