//
//  ExploreViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import Foundation

protocol ExploreViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class ExploreViewModel {
    var api = APIClient()
    var arrayCategory: [Category] = []
    weak var delegate: ExploreViewModelEvents?
    
    func loadItemCategory() {
        api.getCategoryFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (product) in
                        self.arrayCategory.append(product)
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
