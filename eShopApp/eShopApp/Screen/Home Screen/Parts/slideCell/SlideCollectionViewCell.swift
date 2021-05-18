//
//  SlideCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 18/05/2021.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(urlString: String) {
        slideImageView.getImage(urlString: urlString)
    }
}
