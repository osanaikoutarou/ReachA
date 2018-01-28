//
//  TwitterUtility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/01/21.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import TwitterKit
import Swifter

class TwitterUtility: NSObject {
    
    
    class func hoge(vc:UIViewController) {
        
        
        // Instantiation using ACAccount
        //            var swifter = Swifter(account: twitterAccount)
        
        // Instantiation using Twitter's OAuth Consumer Key and secret
        let swifter = Swifter(consumerKey: "uMLpStZCi0tGQmDQkhAHrTuFY", consumerSecret: "rW819KZK6Wdo8nXyVwh9y7aXFOq0YeXMXfcYfbFn4kLeQHcFwH")
        
        //                .slug(listSlug, owner: .screenName(userName)), success: { json, prev, next in
        // alternatively, you can use .id(listId)
        
//        let userTag = UserTag.screenName("sukeroku220")
//        let listTag = ListTag.slug("sukeroku220-1", owner: userTag)
//        let firstCursor = "-1"
//        swifter.getListSubscribers(
//            for: listTag,
//            cursor: nil,
//            includeEntities: true,
//            skipStatus: nil,
//            success: { (json:JSON, prev:String?, next:String?) in
//
//                print("json")
//                print(json)
//                print("prev")
//                if let prev = prev {
//                    print(prev)
//                }
//                if let next = next {
//                    print(next)
//                }
//        }, failure: { error in
//
//            print(error)
//        })
        
        swifter.authorize(with: URL(string: "http://example.com")!,
                          presentFrom:vc ,
                          success: { (accessToken, urlresponse) in
                            
        }, failure: { error in
            
        })

        
        //("yurucamp_anime")
        swifter.getProfileBanner(
            for: .screenName("twitterapi"),
            success: { (json:JSON) in
                
                print(json)
        }, failure: { error in
            
            print(error)
            
        })
        
    }
        
}
    

