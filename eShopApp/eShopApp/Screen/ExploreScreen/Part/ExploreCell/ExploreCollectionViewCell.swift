//
//  ExploreCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView.clipsToBounds = true
        categoryView.layer.cornerRadius = 15
    }
    
    func configure(name: String, image: UIImage, color: UIColor) {
        categoryImageView.image = image
        nameLabel.text = name
        categoryView.backgroundColor = color
    }
}
