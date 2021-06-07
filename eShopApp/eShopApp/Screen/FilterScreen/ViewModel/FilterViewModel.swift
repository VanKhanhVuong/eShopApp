//
//  FilterViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation

protocol FilterViewModelEvents: AnyObject {
    func gotData(isCategoryData: Bool)
    func gotError(messageError: ErrorModel)
}

class FilterViewModel {
    private var api = APIClient()
    var arrayBrand: [Brand] = []
    var arrayCategory: [Category] = []
    let headerTitles = ["Category", "Brand"]
    weak var delegate: FilterViewModelEvents?
    
    func loadData() {
        loadItemCategory()
        loadItemBrand()
    }
    
    func loadItemBrand() {
        api.getBrandFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (brand) in
                        self.arrayBrand.append(brand)
                    }
                    self.delegate?.gotData(isCategoryData: false)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func loadItemCategory() {
        api.getCategoryFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (product) in
                        self.arrayCategory.append(product)
                    }
                    self.delegate?.gotData(isCategoryData: true)
                }
            case .failure(_):
                break
            }
        }
    }
}
