//
//  AccountViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit
import KeychainAccess

class AccountViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userCategoryTableView: UITableView!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentAvatarView: UIView!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    var accountViewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }
    
    func setupView() {
        userCategoryTableView.dataSource = self
        userCategoryTableView.register(cellType: AccountTableViewCell.self)
        
        logoutButton.configureButton()
        
        contentAvatarView.clipsToBounds = true
        contentAvatarView.layer.cornerRadius = contentAvatarView.bounds.size.height/2
    }
    
    func checkLogin() {
        let userId: String = getUserId()
        if !userId.isEmpty {
            logoutButton.setTitle("Log Out", for: .normal)
            showAlert(message: "Logged in successfully")
            emailUserLabel.text = getEmailUser()
            userNameLabel.text = "Welcome"
            userNameLabel.isHidden = false
            emailUserLabel.isHidden = false
            logoutImageView.isHidden = false
        } else {
            userNameLabel.isHidden = true
            emailUserLabel.isHidden = true
            logoutButton.setTitle("Log In", for: .normal)
            logoutImageView.isHidden = true
        }
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        if logoutButton.titleLabel?.text == "Log Out" {
            print("Log Out and delete userID")
            showAlert(message: "You are now logged out")
            checkLogin()
        } else {
            let mainStoryboard = UIStoryboard(name: "SignIn", bundle: .main)
            guard let signInViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
            signInViewController.modalPresentationStyle = .fullScreen
            self.present(signInViewController, animated: true, completion: nil)
        }
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.arrayText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: AccountTableViewCell.self, for: indexPath)
        let image = accountViewModel.arrayImage[indexPath.row]
        let text = accountViewModel.arrayText[indexPath.row]
        itemCell.configure(image: image, text: text)
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
