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
    func gotError(messageError: ErrorModel)
}

class ExploreViewModel {
    var nameCategory: String = ""
    var arrayImageCategory: [UIImage] = []
    var arrayNameCategory: [String] = []
    var arrayIdCategory: [String] = []
    var arrayColorBackground: [UIColor] = []
    var arrayProduct: [Product] = []
    var api = APIClient()
    weak var delegate: ExploreViewModelEvents?
    
    func loadItemCategory() {
        arrayImageCategory = [#imageLiteral(resourceName: "tv"),#imageLiteral(resourceName: "Iphone"),#imageLiteral(resourceName: "Laptop"),#imageLiteral(resourceName: "EarPhone"),#imageLiteral(resourceName: "SmartWatch")]
        arrayIdCategory = ["category001","category002","category003","category005","category006"]
        arrayNameCategory = ["TV","Smart Phone","Laptop","Ear Phone","Smart Watch"]
        arrayColorBackground = [UIColor(red: 230/255, green: 70/255, blue: 63/255, alpha: 1),
                                UIColor(red: 236/255, green: 235/255, blue: 133/255, alpha: 1),
                                UIColor(red: 157/255, green: 172/255, blue: 87/255, alpha: 1),
                                UIColor(red: 138/255, green: 178/255, blue: 228/255, alpha: 1),
                                UIColor(red: 210/255, green: 81/255, blue: 91/255, alpha: 1)
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
                self.delegate?.gotError(messageError: error)
            }
        }
    }
    
    func filterDone(model: FilterViewModel) {
        self.arrayProduct = model.arrayProductFilter
        delegate?.gotFilter()
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
                self.delegate?.gotError(messageError: error)
            }
        }
    }
}
