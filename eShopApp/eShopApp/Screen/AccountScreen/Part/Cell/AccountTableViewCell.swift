//
//  AccountTableViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameItemLabel: UILabel!
    
    func configure(image: UIImage, text: String) {
        iconImageView.image = image
        nameItemLabel.text = text
    }
}
