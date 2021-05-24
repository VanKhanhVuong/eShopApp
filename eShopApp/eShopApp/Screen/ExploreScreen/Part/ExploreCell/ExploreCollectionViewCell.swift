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
        
    }
    
    func configure(item: Category) {
        nameLabel.text = item.categoryName
        categoryImageView.getImage(urlString: item.imageCategory ?? "")
    }
}
