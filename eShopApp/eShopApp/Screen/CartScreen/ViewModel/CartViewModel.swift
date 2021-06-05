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
    
    
    func addOrUpdateAmountProductToCart(productId: String, cartId: String, amount: String) {
        let token = keychain["token"] ?? ""
        if !token.isEmpty {
            filterProductInCart(productId: productId, cartId: cartId, amount: amount)
        }
    }
    
    private func filterProductInCart(productId: String, cartId: String, amount: String) {
        let userId = keychain["token"] ?? ""
        let inCart = arrayCart.filter { $0.productId == productId && $0.userId == userId}
        if inCart.isEmpty {
            // add cart
            print("add cart \(cartId) \(amount)")
            addCart(productId: productId, userId: userId, amount: 1)
        } else {
            // update amount
            print("update amount product in cart id :\(cartId) productid: \(productId) amount: \(amount)")
            guard let amountProduct:Int = Int(amount) else { return }
            updateAmountProduct(idCart: cartId, amount: amountProduct)
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
    func updateAmountProduct(idCart: String, amount: Int) {
        api.updateAmountCartToAPI(id: idCart, amount: amount) { [weak self] result in
            switch result {
            case .success(let result):
                guard let self = self else { return }
                self.messageAddCart = result.status ?? ""
                self.delegate?.gotData(option: .updateCart)
            case .failure(let error):
                self?.delegate?.gotError(messageError: error)
                break
            }
        }
    }
    
    // Delete Cart
    func deleteCart(idCart: String) {
        api.deleteProductCartToAPI(id: idCart){ [weak self] result in
            switch result {
            case .success(let result):
                guard let self = self else { return }
                self.messageAddCart = result.status ?? ""
                self.delegate?.gotData(option: .deleteCart)
            case .failure(let error):
                self?.delegate?.gotError(messageError: error)
                break
            }
        }
    }
}
