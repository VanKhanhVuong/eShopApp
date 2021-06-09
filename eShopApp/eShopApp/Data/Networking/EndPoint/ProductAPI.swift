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
    case getProductByCategory(categoryId: String)
    case getProductByBrand(brandId: String)
    
    // Cart
    case addCart(productId: String, userId: String, amount: Int)
    case findCart(userId: String)
    case checkCart(productId: String, userId: String)
    case deleteProductInCart(id: String)
    case updateAmountInCart(id: String, amount: Int)
    case updateOrderIdToCart(idOrder: String, userId: String)
    
    // Favorite
    case findFavorite(userId: String)
    case checkFavorite(productId: String, userId: String)
    case addFavorite(productId: String, userId: String)
    case deleteFavorite(id: String)
    
    // Search Product
    case getProductByName(productName: String)
    
    // Order
    case createOrder(idOrder: String, delivery: String, pament: String, promoCode: String, idUser: String, totalBill: String)
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
        case .getProduct, .getCategory, .getBrand, .addCart, .findCart, .deleteProductInCart, .updateAmountInCart, .checkCart, .findFavorite, .checkFavorite, .addFavorite, .deleteFavorite, .getProductByBrand, .getProductByCategory, .getProductByName, .updateOrderIdToCart, .createOrder:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .addCart(let productId, let userId, let amount):
            return ["productId": productId,
                    "userId": userId,
                    "amount": amount
            ]
        case .findCart(let userId):
            return ["userId": userId]
        case .checkCart(let productId, let userId):
            return ["productId":productId,
                    "userId":userId
                    
            ]
        case .deleteProductInCart(let id):
            return ["id":id]
        case .updateAmountInCart(let id, let amount):
            return [
                "id": id,
                "amount": amount
            ]
        case .updateOrderIdToCart(let idOrder, let userId):
            return [
                "idOrder":idOrder,
                "userId":userId
            ]
        case .findFavorite(let userId):
            return ["userId": userId]
        case .checkFavorite(let productId, let userId):
            return ["productId":productId,
                    "userId":userId
            ]
        case .addFavorite(let productId, let userId):
            return ["productId":productId,
                    "userId":userId
            ]
        case .deleteFavorite(let id):
            return ["id":id]
        case .getProductByName(let productName):
            return ["productName":productName]
        case .getProductByBrand(let brandId):
            return ["brandId":brandId]
        case .getProductByCategory(let categoryId):
            return ["categoryId":categoryId]
        case .createOrder(let idOrder, let delivery, let pament, let promoCode, let idUser, let totalBill):
            return[
                "idOrder":idOrder,
                "delivery":delivery,
                "pament":pament,
                "idUser":promoCode,
                "idUser":idUser,
                "totalBill":totalBill
            ]
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
            return "add_product_cart.php"
        case .findCart:
            return "get_cart_by_user_id.php"
        case .checkCart:
            return "check_cart.php"
        case .updateOrderIdToCart:
            return "update_idOrder_in_cart.php"
        case .deleteProductInCart:
            return "delete_product_cart.php"
        case .updateAmountInCart:
            return "update_amount_product_cart.php"
        case .addFavorite:
            return "add_product_favorite.php"
        case .findFavorite:
            return "get_favorite_by_user_id.php"
        case .checkFavorite:
            return "check_favorites.php"
        case .deleteFavorite:
            return "delete_product_favorite.php"
        case .getProductByName:
            return "get_product_by_name.php"
        case .getProductByBrand:
            return "get_product_by_brandId.php"
        case .getProductByCategory:
            return "get_product_by_categoryId.php"
        case .createOrder:
            return "create_order.php"
        }
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.path) else { return nil }
        return url
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProduct, .getCategory, .getBrand, .addCart, .findCart, .deleteProductInCart, .updateAmountInCart, .checkCart, .findFavorite, .checkFavorite, .addFavorite, .deleteFavorite, .getProductByName, .getProductByBrand, .getProductByCategory, .updateOrderIdToCart, .createOrder:
            return .get
        }
    }
}
