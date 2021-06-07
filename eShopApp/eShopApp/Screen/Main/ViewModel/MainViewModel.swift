//
//  MainViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 02/06/2021.
//

import Foundation
protocol MainViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: ErrorModel)
}

class MainViewModel {
    var arrayProduct:[Product] = []
    
    weak var delegate: MainViewModelEvents?
    
    func loadData() {
        delegate?.gotData()
    }
}
