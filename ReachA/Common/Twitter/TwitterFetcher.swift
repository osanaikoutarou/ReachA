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
    
    func fetchUser(screenName:String, successHandler: @escaping (Twitter.User) -> Void) {
        
        swifter.showUser(
            for: .screenName(screenName),
            includeEntities: true,
            success: { (json:JSON) in

                print(json)

                let user = Twitter.User.init(json: json)
                successHandler(user)

        }, failure: { error in

            print(error)
        })
    }
    
    func hoge() {
        //https://search.twitter.com/search.json?q=from%3Agoogle%20since%3A2012-01-31%20filter%3Aimages&include_entities=true
        swifter.searchTweet(using: "ゆるキャン filter:images", geocode: nil, lang: nil, locale: nil, resultType: "popular", count: 100, until: nil, sinceID: nil, maxID: nil, includeEntities: true, callback: nil, tweetMode: .extended, success: { (json:JSON, searchMetadata:JSON) in

            var tweets:[Twitter.Tweet] = []
            for j in json.array! {
                let t = Twitter.Tweet.init(json: j)
                tweets.append(t)
            }

            
            
            
        }) { (error:Error) in
            print(error)
        }
    }
    
    func searchMedias(using: String, with success: @escaping (_ tweets: [Twitter.Tweet]) -> Void) {
        swifter.searchTweet(using: using, geocode: nil, lang: nil, locale: nil, resultType: nil, count: 100, until: nil, sinceID: nil, maxID: nil, includeEntities: true, callback: nil, tweetMode: .extended, success: { (json:JSON, searchMetadata:JSON) in
            
            var tweets:[Twitter.Tweet] = []
            for j in json.array! {
                let t = Twitter.Tweet.init(json: j)
                tweets.append(t)
            }
            
            success(tweets)
            
        }) { (error:Error) in
            print(error)
        }

    }
}
