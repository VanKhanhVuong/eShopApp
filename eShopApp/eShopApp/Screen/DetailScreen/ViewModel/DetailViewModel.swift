//
//  DetailViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 22/05/2021.
//

import Foundation

protocol DetailViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class DetailViewModel {
    var api = APIClient()
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
