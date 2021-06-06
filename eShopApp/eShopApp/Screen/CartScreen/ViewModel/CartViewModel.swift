//
//  CartViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation
import KeychainAccess

protocol CartViewModelEvents: AnyObject {
    func gotDataCart(messageChangeData: String)
    func gotErrorCart(messageError: ErrorModel)
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
    
    func filterProductCart(productId: String, amount: String, isCart: Bool) {
        let userId = keychain["token"] ?? ""
        api.checkCartToAPI(productId: productId, userId: userId) { result in
            var arrayFilterCart: [Cart] = []
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (cart) in
                        arrayFilterCart.append(cart)
                    }
                    if arrayFilterCart.count != 0 {
                        if isCart {
                            print("Update amount product in Cart View cartId : \(arrayFilterCart.first?.id ?? "") productid: \(arrayFilterCart.first?.productId ?? "") amount: \(amount)")
                            guard let amountProduct:Int = Int(amount) else { return }
                            self.updateAmountProduct(idCart: arrayFilterCart.first?.id ?? "", amount: amountProduct)
                        } else {
                            guard let amountProduct: Int = Int(arrayFilterCart.first?.amount ?? "") else { return }
                            print("Update amount product cartId : \(arrayFilterCart.first?.id ?? "") productid: \(productId) amount: \(amountProduct + 1)")
                            self.updateAmountProduct(idCart: arrayFilterCart.first?.id ?? "", amount: amountProduct + 1)
                        }
                    }
                } else {
                    guard let amountProduct: Int = Int(amount) else { return }
                    self.addCart(productId: productId, userId: userId, amount: amountProduct)
                }
            case .failure(let error):
                self.delegate?.gotErrorCart(messageError: error)
                break
            }
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
                    self.delegate?.gotDataCart(messageChangeData: "")
                }
            case .failure(let error):
                self.delegate?.gotErrorCart(messageError: error)
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
                self.delegate?.gotDataCart(messageChangeData: "Product added to cart successfully")
            case .failure(let error):
                self?.delegate?.gotErrorCart(messageError: error)
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
                self.findCart()
                self.delegate?.gotDataCart(messageChangeData: "Change the number of products successfully")
            case .failure(let error):
                self?.delegate?.gotErrorCart(messageError: error)
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
                self.findCart()
                self.delegate?.gotDataCart(messageChangeData: "Product removed from cart successfully")
            case .failure(let error):
                self?.delegate?.gotErrorCart(messageError: error)
                break
            }
        }
    }
}
