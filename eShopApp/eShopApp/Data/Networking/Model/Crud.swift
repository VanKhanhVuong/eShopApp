//
//  Crud.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 06/06/2021.
//

import Foundation

struct Crud: Codable {
    var status: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}
