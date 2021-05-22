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
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.gray.cgColor
        
        buyButton.clipsToBounds = true
        buyButton.layer.cornerRadius = 15
    }
    
    func configure(item: Product) {
        itemImageView.getImage(urlString: item.imageProduct ?? "")
        nameItemLabel.text = item.productName
        //unitItemLabel.text = item.
        priceItemLabel.text = item.price
    }
}
