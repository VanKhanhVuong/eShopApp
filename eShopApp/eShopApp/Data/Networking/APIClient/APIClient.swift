//
//  APIClient.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Foundation

class APIClient {
    func addFavoriteToAPI(productId: String, userId: String, completionHandler: @escaping (_ result: Result<Crud, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.addFavorite(productId: productId, userId: userId)) { (result: Result<Crud?, ErrorModel>) in
            switch result {
            case .success(let status):
                guard let statusMessage = status else { return }
                completionHandler(.success(statusMessage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func addCartToAPI(productId: String, userId: String, amount: Int, completionHandler: @escaping (_ result: Result<Crud, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.addCart(productId: productId, userId: userId, amount: amount)) { (result: Result<Crud?, ErrorModel>) in
            switch result {
            case .success(let status):
                guard let statusMessage = status else { return }
                completionHandler(.success(statusMessage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func updateAmountCartToAPI(id: String, amount: Int, completionHandler: @escaping (_ result: Result<Crud, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.updateAmountInCart(id: id, amount: amount)) { (result: Result<Crud?, ErrorModel>) in
            switch result {
            case .success(let status):
                guard let statusMessage = status else { return }
                completionHandler(.success(statusMessage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteProductCartToAPI(id: String, completionHandler: @escaping (_ result: Result<Crud, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.deleteProductInCart(id: id)) { (result: Result<Crud?, ErrorModel>) in
            switch result {
            case .success(let status):
                guard let statusMessage = status else { return }
                completionHandler(.success(statusMessage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteFavoriteToAPI(id: String, completionHandler: @escaping (_ result: Result<Crud, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.deleteFavorite(id: id)) { (result: Result<Crud?, ErrorModel>) in
            switch result {
            case .success(let status):
                guard let statusMessage = status else { return }
                completionHandler(.success(statusMessage))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func findCartToAPI(userId: String, completionHandler: @escaping (_ result: Result<[Cart], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.findCart(userId: userId)) { (result: Result<DataCart?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let carts = data?.cart else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(carts))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func findFavoriteToAPI(userId: String, completionHandler: @escaping (_ result: Result<[Favorite], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.findFavorite(userId: userId)) { (result: Result<DataFavorite?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let favorites = data?.favorite else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(favorites))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func checkCartToAPI(productId: String, userId: String, completionHandler: @escaping (_ result: Result<[Cart], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.checkCart(productId: productId, userId: userId)) { (result: Result<DataCart?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let carts = data?.cart else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(carts))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func checkFavoriteToAPI(productId: String, userId: String, completionHandler: @escaping (_ result: Result<[Favorite], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.checkFavorite(productId: productId, userId: userId)) { (result: Result<DataFavorite?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let favorites = data?.favorite else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(favorites))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getProductFromAPI(completionHandler: @escaping (_ result: Result<[Product], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.getProduct) { (result: Result<DataProduct?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let products = data?.product else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(products))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCategoryFromAPI(completionHandler: @escaping (_ result: Result<[Category], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.getCategory) { (result: Result<DataCategory?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let categorys = data?.category else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(categorys))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBrandFromAPI(completionHandler: @escaping (_ result: Result<[Brand], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: ProductAPI.getBrand) { (result: Result<DataBrand?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let brands = data?.brand else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(brands))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
