//
//  CategoryCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 22/05/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
    }
    
    func configure(item: Category) {
        categoryImageView.getImage(urlString: item.imageCategory ?? "")
        categoryNameLabel.text = item.categoryName
    }

}
