//
//  UIButton+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 02/06/2021.
//

import UIKit

extension UIButton {
    func configureButton() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.titleLabel?.font = UIFont(name: "Gilroy-Bold", size: 18)
    }
}
