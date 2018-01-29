//
//  TwitterUser.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/01/29.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Swifter

class TwitterUser: NSObject {

    var json:JSON?
    
    // 要素
    var name:String?                    // なまえ
    var profileImageUrlHttps:String?     // アイコン
    

    func setup(json:JSON) {
        name = json["name"].string
        profileImageUrlHttps = json["profile_image_url_https"].string
        profileImageUrlHttps = profileImageUrlHttps!.replacingOccurrences(of:"_normal.jpg", with:".jpg")
    }
    
}
