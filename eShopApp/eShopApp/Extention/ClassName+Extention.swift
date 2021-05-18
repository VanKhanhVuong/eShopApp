//
//  ClassName+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }

    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
