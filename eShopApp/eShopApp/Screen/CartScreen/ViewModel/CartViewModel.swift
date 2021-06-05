//
//  CartViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation
import KeychainAccess

protocol CartViewModelEvents: AnyObject {
    func gotData(option: EnumApiCart)
    func gotError(messageError: ErrorModel)
}

class CartViewModel {
    var api = APIClient()
    var keychain = Keychain()
    var messageAddCart: String = ""
    var arrayCart: [Cart] = []
    weak var delegate: CartViewModelEvents?
    
    
    func totalPrice() -> Double{
        var sum: Double = 0.0
        for item in arrayCart {
            guard let price: Double = Double(item.price ?? "") else { return 0.0 }
            guard let amount: Double = Double(item.amount ?? "") else { return 0.0 }
            sum += price * amount
        }
        return sum
    }
    
    
    func addOrUpdateAmountProductToCart(idProduct: String, amount: String) {
        let token = keychain["token"] ?? ""
        if !token.isEmpty {
            filterProductInCart(productId: idProduct, amount: amount)
        }
    }
    
    private func filterProductInCart(productId: String, amount: String) {
        let userId = keychain["token"] ?? ""
        let inCart = arrayCart.filter { $0.productId == productId && $0.userId == userId}
        if inCart.isEmpty {
            // add cart
            print("add cart \(productId) \(amount)")
            //addCart(productId: productId, userId: userId, amount: 1)
        } else {
            // update amount
            print("update amount product in cart product id :\(productId) \(amount)")
            // updateCart(productId: productId, amount: amount)
        }
    }
    
    // Find Cart By UserID
    func findCart() {
        let token = keychain["token"] ?? ""
        arrayCart = []
        api.findCartToAPI(userId: token) { [weak self] result in
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
            case .failure(let error):
                self.delegate?.gotError(messageError: error)
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
            case .failure(let error):
                self?.delegate?.gotError(messageError: error)
                break
            }
        })
    }
    
    // Update Cart
    
    // Delete Cart
}
