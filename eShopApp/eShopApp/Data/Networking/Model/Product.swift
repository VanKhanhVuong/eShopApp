//
//  Product.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Foundation

struct DataProduct: Codable {
    var status: String?
    var product: [Product]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case product = "product"
    }
}

struct Product: Codable {
    var productId: String?
    var productName: String?
    var imageProduct: String?
    var price: String?
    var detail: String?
    var rate: String?
    
    private enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case productName = "productName"
        case imageProduct = "imageProduct"
        case price = "price"
        case detail = "detail"
        case rate = "rate"
    }
}
