//
//  ClassName+Extention.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
