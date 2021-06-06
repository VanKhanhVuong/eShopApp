//
//  Favorite.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 06/06/2021.
//

import Foundation

struct DataFavorite: Codable {
    var status: String?
    var favorite: [Favorite]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case favorite = "favorite"
    }
}

struct Favorite: Codable {
    var id :String?
    var productId: String?
    var productName: String?
    var imageProduct: String?
    var price: String?
    var userId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "productId"
        case productName = "productName"
        case imageProduct = "imageProduct"
        case price = "price"
        case userId = "userId"
    }
}
