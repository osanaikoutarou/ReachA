//
//  TwitterFetcher.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/01/29.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import TwitterKit
import Swifter

class TwitterFetcher: NSObject {

    let swifter:Swifter
    
    override init() {
        swifter = Swifter(consumerKey: "uMLpStZCi0tGQmDQkhAHrTuFY", consumerSecret: "rW819KZK6Wdo8nXyVwh9y7aXFOq0YeXMXfcYfbFn4kLeQHcFwH")
    }
    
    //クロージャがスコープから抜けても存在し続けるときに @escaping が必要になります。
    
    func fetchUser(screenName:String, successHandler: @escaping (TwitterUser) -> Void) {
        
        swifter.showUser(
            for: .screenName(screenName),
            includeEntities: true,
            success: { (json:JSON) in
                
                print(json)
                
                let user = TwitterUser()
                user.setup(json: json)
                
                successHandler(user)
                
        }, failure: { error in
            
            print(error)
        })
        
    }
}