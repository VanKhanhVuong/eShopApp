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
                print(data)
                
//                guard let product = products else {
//                    completionHandler(.failure(ErrorModel.noData))
//                    return
//                }
                
                //completionHandler(.success(product))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
