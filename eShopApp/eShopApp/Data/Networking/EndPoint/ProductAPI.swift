//
//  ProductAPI.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Alamofire

enum ProductAPI {
    case getProduct
    case getCategory
    case getBrand
}

extension ProductAPI: TargetType {
    var baseURL: String {
        "http://localhost/gumi/"
    }
    
    var headers: HTTPHeaders? {
        [
            "Content-Type" : "application/json"
        ]
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getProduct, .getCategory, .getBrand:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        [:]
    }
    
    var path: String {
        switch self {
        case .getProduct:
            return "get_all_product.php"
        case .getCategory:
            return "get_all_category.php"
        case .getBrand:
            return "get_all_brand.php"
        }
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.path) else { return nil }
        return url
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProduct, .getCategory, .getBrand:
            return .get
        }
    }
}
