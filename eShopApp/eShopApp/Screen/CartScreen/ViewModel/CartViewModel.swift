//
//  CartViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation

protocol CartViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class CartViewModel {
    private var api = APIClient()
    var arrayProduct: [Product] = []
    weak var delegate: CartViewModelEvents?
    
    func loadItemProduct() {
        api.getProductFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (product) in
                        self.arrayProduct.append(product)
                    }
                    self.delegate?.gotData()
                }
            case .failure(_):
                //self.delegate?.gotError(messageError: error.rawValue)
                break
            }
        }
    }
}
