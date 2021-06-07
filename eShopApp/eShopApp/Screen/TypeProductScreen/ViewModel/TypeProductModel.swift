//
//  TypeProductModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import Foundation

protocol TypeProductModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class TypeProductModel {
    var api = APIClient()
    var arrayProduct: [Product] = []
    weak var delegate: TypeProductModelEvents?
    
    func loadItemProduct() {
        delegate?.gotData()
    }
}
