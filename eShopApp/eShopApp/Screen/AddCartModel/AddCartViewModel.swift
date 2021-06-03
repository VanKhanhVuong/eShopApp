//
//  AddCartViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 03/06/2021.
//

import Foundation

protocol AddCartViewModelEvents: AnyObject {
    func gotData(option: EnumApiCart)
    func gotError(messageError: ErrorModel)
}

class AddCartViewModel {
    var api = APIClient()
    var messageAddCart: String = ""
    var arrayCart: [Cart] = []
    weak var delegate: AddCartViewModelEvents?
    
    // Find Cart By UserID
    func findCart(userId: String) {
        arrayCart = []
        api.findCartToAPI(userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (cart) in
                        self.arrayCart.append(cart)
                    }
                    print(self.arrayCart)
                    self.delegate?.gotData(option: .showCart)
                }
            case .failure(_):
                //self.delegate?.gotError(messageError: error.rawValue)
                break
            }
        }
    }
    
    // Add Cart
    func addCart(productId: String, userId: String, amount: Int) {
        api.addCartToAPI(productId: productId, userId: userId, amount: amount, completionHandler: { [weak self] result in
            switch result {
            case .success(let result):
                guard let self = self else { return }
                self.messageAddCart = result.status ?? ""
                self.delegate?.gotData(option: .createCart)
            case .failure(_):
                //self.delegate?.gotError(messageError: error.)
                break
            }
        })
    }
    
    // Update Cart
    
    // Delete Cart
}
