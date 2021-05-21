//
//  ErrorModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import Foundation

enum ErrorModel: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case timeOut = "The url you requested is timeOut."
    case gone = "This response is sent when the requested content has been permanently deleted from server"
    case forbidden = "The client does not have access rights to the content"
    case unknownError = "Network request failed."
    case unableToDecode
    case noData = "Response returned with no data to decode."
    case notFound = "The server can not find the requested resource"
    init(responseDataStatus code: HTTPURLResponse ) {
        switch code.statusCode {
        case 401:
            self = .authenticationError
        case 400:
            self = .badRequest
        case 410:
            self = .gone
        case 403:
            self = .forbidden
        case 408:
            self = .timeOut
        case 204:
            self = .noData
        case 404:
            self = .notFound
        default:
            self = .unknownError
        }
    }
}
