//
//  CartViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import Foundation

protocol CartViewModelEvents: AnyObject {
    func gotDataCart(messageChangeData: String)
    func gotAmountProduct(amount: String)
    func gotErrorCart(messageError: String)
}

class CartViewModel {
    var api = APIClient()
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
    
    func findAmountProduct(productId: String, userId: String) {
        if !userId.isEmpty {
            api.checkCartToAPI(productId: productId, userId: userId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let amount):
                    if !amount.isEmpty {
                        self.delegate?.gotAmountProduct(amount: "\(amount.first?.amount ?? "")")
                    } else {
                        self.delegate?.gotAmountProduct(amount: "1")
                    }
                case .failure(let error):
                    self.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
    
    func filterProductCart(productId: String, amount: String, isCart: Bool, userId: String) {
        if !userId.isEmpty {
            api.checkCartToAPI(productId: productId, userId: userId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let carts):
                    if !carts.isEmpty {
                        if isCart {
                            print("Update amount product in Cart View cartId : \(carts.first?.id ?? "") productid: \(carts.first?.productId ?? "") amount: \(amount)")
                            guard let amountProduct:Int = Int(amount) else { return }
                            self.updateAmountProduct(idCart: carts.first?.id ?? "", amount: amountProduct, userId: userId)
                        } else {
                            guard let amountProduct: Int = Int(carts.first?.amount ?? "") else { return }
                            print("Update amount product cartId : \(carts.first?.id ?? "") productid: \(productId) amount: \(amountProduct + 1)")
                            self.updateAmountProduct(idCart: carts.first?.id ?? "", amount: amountProduct + 1, userId: userId)
                        }
                    } else {
                        guard let amountProduct: Int = Int(amount) else { return }
                        self.addCart(productId: productId, userId: userId, amount: amountProduct)
                    }
                case .failure(let error):
                    self.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
    
    // Find Cart By UserID
    func findCart(userId: String) {
        if !userId.isEmpty {
            arrayCart.removeAll()
            api.findCartToAPI(userId: userId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let carts):
                    if !carts.isEmpty {
                        self.arrayCart = carts
                        print(self.arrayCart)
                        self.delegate?.gotDataCart(messageChangeData: "")
                    }
                case .failure(let error):
                    self.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
    
    // Add Cart
    func addCart(productId: String, userId: String, amount: Int) {
        if !userId.isEmpty {
            api.addCartToAPI(productId: productId, userId: userId, amount: amount) { [weak self] result in
                switch result {
                case .success(let result):
                    guard let self = self else { return }
                    self.messageAddCart = result.status ?? ""
                    self.delegate?.gotDataCart(messageChangeData: "Product added to cart successfully")
                case .failure(let error):
                    self?.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
    
    // Update Cart
    func updateAmountProduct(idCart: String, amount: Int, userId: String) {
        if !userId.isEmpty {
            api.updateAmountCartToAPI(id: idCart, amount: amount) { [weak self] result in
                switch result {
                case .success(let result):
                    guard let self = self else { return }
                    self.messageAddCart = result.status ?? ""
                    self.findCart(userId: userId)
                    self.delegate?.gotDataCart(messageChangeData: "Change the number of products successfully")
                case .failure(let error):
                    self?.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
    
    // Delete Cart
    func deleteCart(idCart: String, userId: String) {
        if !userId.isEmpty {
            api.deleteProductCartToAPI(id: idCart){ [weak self] result in
                switch result {
                case .success(let result):
                    guard let self = self else { return }
                    self.messageAddCart = result.status ?? ""
                    self.findCart(userId: userId)
                    self.delegate?.gotDataCart(messageChangeData: "Product removed from cart successfully")
                case .failure(let error):
                    self?.delegate?.gotErrorCart(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorCart(messageError: "Please Login")
        }
    }
}
