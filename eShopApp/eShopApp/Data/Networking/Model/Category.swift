//
//  Category.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 22/05/2021.
//

import Foundation

struct DataCategory: Codable {
    var status: String?
    var category: [Category]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case category = "category"
    }
}

struct Category: Codable {
    var categoryId: String?
    var categoryName: String?
    var imageCategory: String?
    
    private enum CodingKeys: String, CodingKey {
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case imageCategory = "imageCategory"
    }
}

