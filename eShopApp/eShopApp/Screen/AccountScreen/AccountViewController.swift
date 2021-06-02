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
    let keychain = Keychain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }
    
    @available(iOS 13.0, *)
    @IBAction func touchLogOutTapped(_ sender: Any) {
        if logoutButton.titleLabel?.text == "Log Out" {
            print("Log Out and delete userID")
            keychain[string: "token"] = ""
        } else {
            let mainStoryboard = UIStoryboard(name: "SignIn", bundle: .main)
            guard let signInViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
            self.navigationController?.pushViewController(signInViewController, animated: true)
        }
    }
    
    func setupView() {
        userCategoryTableView.dataSource = self
        userCategoryTableView.register(cellType: AccountTableViewCell.self)
        
        logoutButton.clipsToBounds = true
        logoutButton.layer.cornerRadius = 15
        
        contentAvatarView.clipsToBounds = true
        contentAvatarView.layer.cornerRadius = contentAvatarView.bounds.size.height/2
    }
    
    func checkLogin() {
        
        let token = keychain["token"] ?? ""
        if !token.isEmpty {
            logoutButton.setTitle("Log Out", for: .normal)
            logoutImageView.isHidden = false
        } else {
            logoutButton.setTitle("Log In", for: .normal)
            logoutImageView.isHidden = true
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
