//
//  ExploreViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

protocol ExploreViewModelEvents: AnyObject {
    func gotData()
    func gotMessage(message: String)
    func gotError(messageError: ErrorModel)
}

class ExploreViewModel {
    var arrayImageCategory: [UIImage] = []
    var arrayNameCategory: [String] = []
    var arrayColorBackground: [UIColor] = []
    var arrayProductByName: [Product] = []
    var api = APIClient()
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
        self.delegate?.gotData()
    }
    
    func searchProductByName(productName: String) {
        arrayProductByName = []
        api.getProductByNameFromAPI(productName: productName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (products) in
                        self.arrayProductByName.append(products)
                        
                    }
                    print(self.arrayProductByName)
                    self.delegate?.gotData()
                } else {
                    self.delegate?.gotMessage(message: "No product found named \(productName)")
                }
            case .failure(let error):
                self.arrayProductByName = []
                self.delegate?.gotError(messageError: error)
            }
        }
    }
}
