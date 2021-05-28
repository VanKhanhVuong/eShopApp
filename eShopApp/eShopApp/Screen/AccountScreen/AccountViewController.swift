//
//  AccountViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userCategoryTableView: UITableView!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentAvatarView: UIView!
    
    var accountViewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {

        userCategoryTableView.dataSource = self
        userCategoryTableView.register(cellType: AccountTableViewCell.self)
        
        logoutButton.clipsToBounds = true
        logoutButton.layer.cornerRadius = 15
        
        contentAvatarView.clipsToBounds = true
        contentAvatarView.layer.cornerRadius = contentAvatarView.bounds.size.height/2
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.arrayCategoryUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: AccountTableViewCell.self, for: indexPath)
        let image = accountViewModel.arrayCategoryUser[indexPath.row]
        itemCell.configure(item: image)
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
