//
//  TestCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 18/05/2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var unitItemLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    
    func configure() {
        //itemImageView.getImage(urlString: item.urlString)
        //nameItemLabel.text = item.name
        //unitItemLabel.text = item.unit
        //priceItemLabel.text = "\(item.price)"
    }
}
