//
//  Channel.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/25.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

enum StatesType {
}

enum ChannelType {
    case animeChannel
}

class Channel: NSObject {
    
    var id:String?                  // Account ID
    var name:String?                // Account name
    var type:ChannelType = .animeChannel
    var officialUrl:String?         // 公式サイトのURL
    var wikipedia:String?           // wikipediaのURL
    var twitterScreenName:String?   // Twitter
    
    var topImageURL:String = ""
    var descriptionText:String = ""
    var isFollow:Bool = false
    var statesType:StatesType?
    var tags:[String]
    
    var sigInfos:[String]?
    var relatedChannels:[Channel]
    
    //TODO:放送時間、スケジュール、放送局、放送地域、評価感想、自分の評価感想
    
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
