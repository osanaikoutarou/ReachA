//
//  StringUtility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/01.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation

extension String {
    
    var url:URL {
        return URL(string:self)!
    }
}
