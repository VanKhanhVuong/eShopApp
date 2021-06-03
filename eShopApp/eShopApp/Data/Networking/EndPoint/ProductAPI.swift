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
    case addCart(productId: String, userId: String, amount: Int)
    case findCart(userId: String)
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
        case .getProduct, .getCategory, .getBrand, .addCart, .findCart:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
            case .addCart(let productId, let userId, let amount):
                return [
                    "productId": productId,
                    "userId": userId,
                    "amount": amount
                ]
            case .findCart(let userId):
                return ["userId": userId]
            case .getProduct, .getCategory, .getBrand:
                return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getProduct:
            return "get_all_product.php"
        case .getCategory:
            return "get_all_category.php"
        case .getBrand:
            return "get_all_brand.php"
        case .addCart:
            return "cart.php"
        case .findCart:
            return "get_cart_by_user_id.php"
        }
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.path) else { return nil }
        return url
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProduct, .getCategory, .getBrand, .addCart, .findCart:
            return .get
        }
    }
}
