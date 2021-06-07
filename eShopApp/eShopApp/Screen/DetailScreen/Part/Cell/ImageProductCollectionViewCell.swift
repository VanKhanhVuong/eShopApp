//
//  ImageProductCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

class ImageProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(imageProduct: String) {
        productImageView.getImage(urlString: imageProduct)
    }

}
