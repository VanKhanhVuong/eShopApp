//
//  AccountTableViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var nameItemLabel: UILabel!
    
    func configure(item: CategoryUser) {
        iconLabel.text = item.imageCategoryUser
        nameItemLabel.text = item.nameCategoryUser
    }
}
