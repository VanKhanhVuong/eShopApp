//
//  DetailViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 22/05/2021.
//

import Foundation

protocol DetailViewModelEvents: AnyObject {
    func gotData(isData: Bool)
    func gotError(messageError: ErrorModel)
}

class DetailViewModel {
    var api = APIClient()
    var itemProduct: Product = Product()
    var productName: String = ""
    var productUnit: String = ""
    var productPrice: Float = 0.0
    var productDetail: String = ""
    var productId: String = ""
    var productImage: String = ""
    var productRate: Int = 0
    var arrayImageProduct: [String] = []
    weak var delegate: DetailViewModelEvents?
    
    func getData() {
        self.productName = itemProduct.productName ?? ""
        //self.productUnit = itemProduct.productUnit ?? ""
        self.productPrice = Float(itemProduct.price ?? "") ?? 0.0
        self.productDetail = itemProduct.detail ?? ""
        self.productImage = itemProduct.imageProduct ?? ""
        self.productId = itemProduct.productId ?? ""
        self.productRate = Int(itemProduct.rate ?? "") ?? 0
        delegate?.gotData(isData: true)
    }
    
    func loadItemImageProduct() {
        arrayImageProduct.append(productImage)
        arrayImageProduct.append(productImage)
        arrayImageProduct.append(productImage)
        delegate?.gotData(isData: false)
    }
    
    //var arrayImageProduct: [ImageProduct] = []
    
//    func loadItemImageProduct() {
//        api.getImageFromAPI { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let result):
//                if !result.isEmpty {
//                    result.forEach { (imageProduct) in
//                        self.arrayImageProduct.append(imageProduct)
//                    }
//                    self.delegate?.gotData()
//                }
//            case .failure(_):
//                //self.delegate?.gotError(messageError: error.rawValue)
//                break
//            }
//        }
//    }
}
