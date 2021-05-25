//
//  FavoritesViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import Foundation

protocol FavoritesViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class FavoritesViewModel {
    private var api = APIClient()
    var arrayProduct: [Product] = []
    weak var delegate: FavoritesViewModelEvents?
    
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
