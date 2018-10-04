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
    case normal
    // content
    case anime
    case comic
    case webComic
    case music
    case video
    case event
    case caractor
    case otherContent   //まだまだある
    // man
    // organization
    // information
    
}

class Channel: NSObject {
    
    var id:String = ""                  // Account ID
    var name:String = ""                // Account name
    var type:ChannelType = .anime
    var officialUrl:String = ""         // 公式サイトのURL
    var wikipedia:String = ""           // wikipediaのURL
    var twitterScreenName:String = ""   // Twitter
    
    var topImageURL:String = ""
    var descriptionText:String = ""
    var isFollow:Bool = false
    var statesType:StatesType?
    var tags:[String] = []
    
    var sigInfos:[String] = []
    var relatedChannels:[Channel] = []
    
    //TODO:放送時間、スケジュール、放送局、放送地域、評価感想、自分の評価感想
    
    var twitterUser:Twitter.User?

    static func create(_ dic:[String:Any]) -> Channel {
        let obj = Channel()
        obj.id = String(dic["id"] as! Int)
        obj.name = dic["name"] as! String
        obj.type = .anime
        obj.officialUrl = dic["officialUrl"] as! String
        obj.wikipedia = dic["wikipedia"] as! String
        obj.twitterScreenName = (dic["twitter"] as! [String:Any])["screenName"] as! String
        
        return obj
    }
    
    func setup(completion: ((Bool) -> Void)?) {
        setupTwitter(completion: completion)
    }
    
    func setupTwitter(completion: ((Bool) -> Void)?) {
        
        let twitterFetcher = TwitterFetcher()
        twitterFetcher.fetchUser(
            screenName: twitterScreenName,
            successHandler: { (tu:Twitter.User) in
                self.twitterUser = tu
                
                if let completion = completion {
                    completion(true)
                }
        })
    }
    
    func printDescription() {
        print("[Channel] \(id) \(name) \(type) \(officialUrl) \(wikipedia) \(twitterScreenName) ")
    }
    
}
