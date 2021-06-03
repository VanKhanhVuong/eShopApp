//
//  ExploreViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

protocol ExploreViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class ExploreViewModel {
    var arrayImageCategory: [UIImage] = []
    var arrayNameCategory: [String] = []
    var arrayColorBackground: [UIColor] = []
    weak var delegate: ExploreViewModelEvents?
    
    func loadItemCategory() {
        arrayImageCategory = [#imageLiteral(resourceName: "tv"),#imageLiteral(resourceName: "Iphone"),#imageLiteral(resourceName: "Laptop"),#imageLiteral(resourceName: "EarPhone"),#imageLiteral(resourceName: "SmartWatch")]
        arrayNameCategory = ["TV","Smart Phone","Laptop","Ear Phone","Smart Watch"]
        arrayColorBackground = [UIColor(red: 230/255, green: 70/255, blue: 63/255, alpha: 1),
                                UIColor(red: 236/255, green: 235/255, blue: 133/255, alpha: 1),
                                UIColor(red: 157/255, green: 172/255, blue: 87/255, alpha: 1),
                                UIColor(red: 138/255, green: 178/255, blue: 228/255, alpha: 1),
                                UIColor(red: 210/255, green: 81/255, blue: 91/255, alpha: 1)
        ]
    }
}
