//
//  FilterViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation

protocol FilterViewModelEvents: AnyObject {
    func gotData(isCategoryData: Bool)
    func gotFilter()
    func gotError(messageError: ErrorModel)
}

class FilterViewModel {
    private var api = APIClient()
    var arrayBrand: [Brand] = []
    var arrayCategory: [Category] = []
    var arrayProduct: [Product] = []
    var arrayProductFilter: [Product] = []
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
            case .failure(let error):
                self.delegate?.gotError(messageError: error)
            }
        }
    }
    
    func getData(array: [String]) {
        var arrayCategory:[Product] = []
        var arrayBrand:[Product] = []
        array.forEach { name in
            let string = name[name.startIndex]
            if string ==  "c" {
                print(string)
                arrayCategory = self.arrayProduct.filter { $0.categoryId == name}
                print(arrayCategory)
            } else {
                print(string)
                arrayBrand = self.arrayProduct.filter { $0.brandId == name}
                print(arrayBrand)
            }
        }
        
        if !arrayCategory.isEmpty {
            if !arrayBrand.isEmpty {
                let arrayCategorySet = Set(arrayCategory)
                let arrayBrandSet = Set(arrayBrand)
                let output = Array(arrayLiteral: arrayCategorySet.intersection(arrayBrandSet))
                let flat = output.flatMap{$0}
                self.arrayProductFilter = flat
                delegate?.gotFilter()
            } else {
                print(arrayCategory)
                self.arrayProductFilter = arrayCategory
                delegate?.gotFilter()
            }
        } else {
            if !arrayBrand.isEmpty {
                self.arrayProductFilter = arrayBrand
                delegate?.gotFilter()
            } else {
                self.arrayProductFilter.removeAll()
                delegate?.gotFilter()
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
            case .failure(let error):
                self.delegate?.gotError(messageError: error)
            }
        }
    }
}
