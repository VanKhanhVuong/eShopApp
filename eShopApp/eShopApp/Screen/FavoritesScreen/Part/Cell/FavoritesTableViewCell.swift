//
//  FavoritesTableViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    
    func configure(item: Favorite) {
        productImageView.getImage(urlString: item.imageProduct ?? "")
        priceLabel.text = "$\(item.price ?? "")"
//        unitLabel.text = item.unit
        nameProductLabel.text = item.productName
    }
}
