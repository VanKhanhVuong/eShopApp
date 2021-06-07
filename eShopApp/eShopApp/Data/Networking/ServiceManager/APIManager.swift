//
//  APIManager.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Alamofire

final class APIManager {
    static var shared = APIManager()
    private init() { }
}

extension APIManager {
    func requestApi<T>(type: TargetType, completionHandler: @escaping (_ result: Result<T?, ErrorModel>) -> ()) where T: Codable {
        guard let url = type.url else {
            completionHandler(.failure(ErrorModel.unknownError))
            return
        }
        AF.request(url, method: type.httpMethod, parameters: type.parameters, encoding: type.encoding, headers: type.headers)
            .validate()
            .responseJSON { data in
                switch data.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        guard let responseModel = try? decoder.decode(T.self, from: jsonData) else {
                            completionHandler(.failure(ErrorModel.unableToDecode))
                            return
                        }
                        completionHandler(.success(responseModel))
                    }
                    break
                case .failure(_):
                    guard let response = data.response else { return }
                    completionHandler(.failure(ErrorModel.init(responseDataStatus: response)))
                    break
                }
            }
    }
}

