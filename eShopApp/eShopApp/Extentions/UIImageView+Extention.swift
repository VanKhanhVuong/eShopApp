//
//  UIImageView+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImage(urlString: String) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url)
    }
}
