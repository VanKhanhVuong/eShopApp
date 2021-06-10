//
//  TypeProductModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import Foundation

protocol TypeProductModelEvents: AnyObject {
    func gotData()
    func gotFilter()
    func gotError(messageError: String)
}

class TypeProductModel {
    var api = APIClient()
    var arrayProduct: [Product] = []
    var arrayProductFilter: [Product] = []
    weak var delegate: TypeProductModelEvents?
    
    func loadItemProduct() {
        delegate?.gotData()
    }
    
    func filterDone(model: FilterViewModel) {
        self.arrayProductFilter = model.arrayProductFilter
        if !self.arrayProductFilter.isEmpty {
            delegate?.gotFilter()
        } else {
            delegate?.gotError(messageError: "Not fount")
        }
    }
}
