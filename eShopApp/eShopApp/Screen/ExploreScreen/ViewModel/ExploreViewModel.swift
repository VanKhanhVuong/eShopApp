//
//  ExploreViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

protocol ExploreViewModelEvents: AnyObject {
    func gotData(isSearch: Bool)
    func gotFilter()
    func gotMessage(message: String)
    func gotError(messageError: String)
}

class ExploreViewModel {
    var nameCategory: String = ""
    var arrayImageCategory: [UIImage] = []
    var arrayNameCategory: [String] = []
    var arrayIdCategory: [String] = []
    var arrayColorBackground: [UIColor] = []
    var arrayProduct: [Product] = []
    var arrayProductFilter: [Product] = []
    var api = APIClient()
    weak var delegate: ExploreViewModelEvents?
    
    func loadItemCategory() {
        arrayImageCategory = [#imageLiteral(resourceName: "tv"),#imageLiteral(resourceName: "Iphone"),#imageLiteral(resourceName: "Laptop"),#imageLiteral(resourceName: "EarPhone"),#imageLiteral(resourceName: "SmartWatch")]
        arrayIdCategory = ["category001","category002","category003","category005","category006"]
        arrayNameCategory = ["TV","Smart Phone","Laptop","Ear Phone","Smart Watch"]
        arrayColorBackground = [UIColor(red: 238/255, green: 247/255, blue: 241/255, alpha: 1),
                                UIColor(red: 254/255, green: 246/255, blue: 237/255, alpha: 1),
                                UIColor(red: 253/255, green: 231/255, blue: 228/255, alpha: 1),
                                UIColor(red: 244/255, green: 235/255, blue: 247/255, alpha: 1),
                                UIColor(red: 255/255, green: 249/255, blue: 229/255, alpha: 1)
        ]
        self.delegate?.gotData(isSearch: true)
    }
    
    func searchProductByName(productName: String) {
        arrayProduct.removeAll()
        api.getProductByNameFromAPI(productName: productName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if !products.isEmpty {
                    self.arrayProduct = products
                    print(self.arrayProduct)
                    self.delegate?.gotData(isSearch: true)
                } else {
                    self.delegate?.gotMessage(message: "No product found named \(productName)")
                }
            case .failure(let error):
                self.arrayProduct.removeAll()
                self.delegate?.gotError(messageError: error.rawValue)
            }
        }
    }
    
    func filterDone(model: FilterViewModel) {
        self.arrayProductFilter = model.arrayProductFilter
        if !self.arrayProductFilter.isEmpty {
            delegate?.gotFilter()
        } else {
            delegate?.gotError(messageError: "Can't filter")
        }
    }

    func getProductByCategory(categoryId: String, categoryName: String) {
        api.getProductByCategoryFromAPI(categoryId: categoryId) {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if !products.isEmpty {
                    self.arrayProduct = products
                    print(self.arrayProduct)
                    self.nameCategory = categoryName
                    self.delegate?.gotData(isSearch: false)
                } else {
                    self.delegate?.gotMessage(message: "Sorry we don't have \(categoryName) products.")
                }
            case .failure(let error):
                self.arrayProduct.removeAll()
                self.delegate?.gotError(messageError: error.rawValue)
            }
        }
    }
}
