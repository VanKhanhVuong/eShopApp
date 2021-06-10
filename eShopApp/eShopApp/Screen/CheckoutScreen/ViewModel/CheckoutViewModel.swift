//
//  CheckoutViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 09/06/2021.
//

import Foundation

protocol CheckoutViewModelEvents: AnyObject {
    func gotData()
    func gotError(messageError: String)
}

class CheckoutViewModel {
    weak var delegate: CheckoutViewModelEvents?
    var api = APIClient()
    var idOrder: String = ""
    var totalBill: String = ""

    func createOrder(idUser: String) {
        let delivery: String = "23/1"
        let pament: String = "Card"
        let promoCode: String = "0.2"
        api.createOrder(idOrder: idOrder, delivery: delivery, pament: pament, promoCode: promoCode, idUser: idUser, totalBill: totalBill){ [weak self] result in
            switch result {
            case .success(_):
                guard let self = self else { return }
                self.delegate?.gotData()
            case .failure(let error):
                self?.delegate?.gotError(messageError: error.rawValue)
                break
            }
        }
    }
}
