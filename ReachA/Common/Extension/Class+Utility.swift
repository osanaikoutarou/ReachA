//
//  ClassUtility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

