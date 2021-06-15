//
//  HomeViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit

protocol HomeViewModelEvents: AnyObject {
    func gotData(isCategory: Bool, categoryName: String)
    func gotError(messageError: ErrorModel)
}

class HomeViewModel {
    weak var delegate: HomeViewModelEvents?
    var cartViewModel = CartViewModel()
    var api = APIClient()
    var arrayProductExclusive: [Product] = []
    var arrayProductCheap: [Product] = []
    var arrayCategoryId: [String] = []
    var arrayProductBestSelling: [Product] = []
    var arrayProductByCategory: [Product] = []
    var arrayImageCategory: [UIImage] = []
    var arrayNameCategory: [String] = []
    var arrayColorBackground: [UIColor] = []
    var messageAddCart: String = ""
    
    var arrayPoster: [String] = ["https://cdn.tgdd.vn/2021/05/banner/hotsale-830-300-830x300-2.png",
                                 "https://cdn.tgdd.vn/2021/05/banner/big-samsung-830-300-830x300.png",
                                 "https://cdn.tgdd.vn/2021/05/banner/reno5-830-300-830x300-1.png",
                                 "https://cdn.tgdd.vn/2021/05/banner/830-300-830x300-15.png"]
    
    func loadCategory() {
        arrayImageCategory = [#imageLiteral(resourceName: "tv"),#imageLiteral(resourceName: "Iphone"),#imageLiteral(resourceName: "Laptop"),#imageLiteral(resourceName: "EarPhone"),#imageLiteral(resourceName: "SmartWatch")]
        arrayNameCategory = ["TV","Smart Phone","Laptop","Ear Phone","Smart Watch"]
        arrayCategoryId = ["category001","category002","category003","category005","category006"]
        arrayColorBackground = [UIColor(red: 238/255, green: 247/255, blue: 241/255, alpha: 1),
                                UIColor(red: 254/255, green: 246/255, blue: 237/255, alpha: 1),
                                UIColor(red: 253/255, green: 231/255, blue: 228/255, alpha: 1),
                                UIColor(red: 244/255, green: 235/255, blue: 247/255, alpha: 1),
                                UIColor(red: 255/255, green: 249/255, blue: 229/255, alpha: 1)
        ]
    }
    
    func loadItemProductByCategory(categoryId: String, categoryName: String) {
        arrayProductByCategory.removeAll()
        api.getProductByCategoryFromAPI(categoryId: categoryId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if !products.isEmpty {
                    self.arrayProductByCategory = products
                    print(self.arrayProductByCategory)
                    self.delegate?.gotData(isCategory: true, categoryName: categoryName)
                }
            case .failure(let error):
                self.delegate?.gotError(messageError: error)
                break
            }
        }
    }

    func loadItemProduct() {
        api.getProductFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if !products.isEmpty {
                    products.forEach { (product) in
                        if product.base == BaseProduct.exclusiveOffer.rawValue {
                            self.arrayProductExclusive.append(product)
                        } else if product.base == BaseProduct.cheapProducts.rawValue {
                            self.arrayProductCheap.append(product)
                        } else {
                            self.arrayProductBestSelling.append(product)
                        }
                    }
                    self.delegate?.gotData(isCategory: false, categoryName: "")
                }
            case .failure(let error):
                self.delegate?.gotError(messageError: error)
                break
            }
        }
    }
}
