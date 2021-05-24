//
//  APIClient.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Foundation

class APIClient {
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
