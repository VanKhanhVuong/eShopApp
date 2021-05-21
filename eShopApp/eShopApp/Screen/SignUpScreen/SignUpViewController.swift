//
//  SignUpViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var messageSignUpView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSignUpView.titleLabel.text = "Sign Up"
        messageSignUpView.subtitleLabel.text = "Enter your credentials to continue"
    }
}
