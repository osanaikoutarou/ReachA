//
//  WKWebView+Utility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func load (with urlStr:String) {
        if !urlStr.isEmpty {
            let urlRequest = URLRequest(url: urlStr.url)
            self.load(urlRequest)
        }
    }
}
