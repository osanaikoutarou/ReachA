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
    
    func sw4substring(to index:Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
}


class hoge {
    
    func wa() {
        self.abcde(aaa: "a", bbb: "b", from: "c", with: "d", hage: "e")
    }
    
    func abcde(aaa:String, bbb:String, from ccc:String, with ddd:String, hage eee:String) {
        
        let www = ccc
    }
    
}
