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

// checkout bên này call api fill data từ màn hình
// idOder đã lấy, delivery từ man hinh kia, ....., idUser, promoCode = -10%,... tổng bill khi đa giam gia totalBill -20%
// Nếu api trả về done thì ra man hình
// Ngược lại ra màn hinh thất bại

class CheckoutViewModel {
    weak var delegate: CheckoutViewModelEvents?
    var api = APIClient()
    
}
