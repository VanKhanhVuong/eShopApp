//
//  TargetType.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Alamofire

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var url: URL? { get }
    var encoding: ParameterEncoding { get }
}
