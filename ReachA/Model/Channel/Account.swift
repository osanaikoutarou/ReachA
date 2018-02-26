//
//  Channel.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/25.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class Channel: NSObject {
    
    var id:String?                  // Account ID
    var name:String?                // Account name
    var officialUrl:String?         // 公式サイトのURL
    var wikipedia:String?           // wikipediaのURL
    var twitterScreenName:String?   // Twitter
    
    
    var twitterUser:TwitterUser?
    
    override init() {
    }
    
    func setup(completion: ((Bool) -> Void)?) {
        setupTwitter(completion: completion)
    }
    
    func setupTwitter(completion: ((Bool) -> Void)?) {
        
        guard let twitterScreenName = twitterScreenName else {
            return;
        }
        
        let twitterFetcher = TwitterFetcher()
        twitterFetcher.fetchUser(
            screenName: twitterScreenName,
            successHandler: { (tu:TwitterUser) in
                self.twitterUser = tu
                
                if let completion = completion {
                    completion(true)
                }
        })
    }
    
}
