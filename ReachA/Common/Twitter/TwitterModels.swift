//
//  TwitterModels.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/01/29.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Swifter

//class TwitterUser: NSObject {
//    var json:JSON?
//    var twitterUserRaw:TwitterUserRaw?
//
//    // 要素
//    var name:String?                     // なまえ
//    var profileImageUrlHttps:String?     // アイコン
//
//    func setup(json:JSON) {
//        twitterUserRaw = TwitterUserRaw(json: json)
//
//        if var twitterUserRaw = twitterUserRaw {
//            name = twitterUserRaw.name
//            profileImageUrlHttps = twitterUserRaw.profileImageUrlHttps!.replacingOccurrences(of:"_normal.jpg", with:".jpg")
//
//            print(twitterUserRaw)
//        }
//    }
//}

class Twitter {
    
    // 参考になりそう:http://syossan.hateblo.jp/entry/20110219/1298099350
    class User: NSObject {
        var timeZone:String?
        var protected:Bool?
        var profileSidebarBorderColor:String?   //サイドバーボーダーカラー
        var profileLinkColor:String?            //プロフィールリンクカラー
        var lang:String?                         //言語
        var favouritesCount:Int?              //ふぁぼった数
        var defaultProfileImage:String?     //?
        var profileBackgroundColor:String?  // 背景
        var profileLocation:String?
        var profileBackgroundTile:Bool?  //画像をタイル状にするか
        var profileSidebarFillColor:String? //ユーザマイページサイドバーの背景色
        var isTranslator:Bool?               //Interested in helping translate Twitter? Check out the Translation Center.」のリンク
        var isTranslationEnabled:Bool?
        var profileImageUrlHttps:String?
        var friendsCount:Int?       // フォロー数
        var profileBackgroundImageUrlHttps:String?
        var utcOffset:String?        //ユーザが設定しているタイムゾーンとUTC（協定世界時）との差
        var profileImageUrl:String?      // http
        var statusesCount:Int?              //ツイート数
        var defaultProfile:Bool?     //?
        var following:Bool?          // フォローしているかどうか　連携してないからnullだ
        var url:String?              // web url
        var name:String?             // ユーザー名
        var geoEnabled:Bool?         // ツイートに位置情報をつけるか
        var profileUseBackgroundImage:Bool?      // 背景画像を用いるかどうか
        var screenName:String?                   // ユーザー名
        var descriptionStr:String?                  // 説明
        var notifications:Bool?                  // 指定ユーザからの通知メールを受け取るかどうか
        var contributorsEnabled:Bool?            // Twitterのライター機能を使用しているかどうか
        var hasExtendedProfile:Bool?         // ?
        var followersCount:Int?             // フォロワーの数
        var location:String?                 //ロケーション文字列
        var verified:Bool?                   // 認証済みアカウントかどうか
        var createdAt:String?
        var followRequestSent:Bool?          // 鍵付きユーザに対し、フォロー申請したかどうか
        var id:Int?
        var idStr:String?
        var profileBannerUrl:String?
        var profileBackgroundImageUrl:Bool?
        var profivarextColor:String?
        var translatorType:String?           // ?
        
        override init() {
            super.init()
        }
        
        init(json:JSON) {
            timeZone = json["time_zone"].string
            protected = json["protected"].bool
            profileSidebarBorderColor = json["profile_sidebar_border_color"].string
            profileLinkColor = json["profile_link_color"].string
            lang = json["lang"].string
            favouritesCount = json["favorites_count"].integer
            defaultProfileImage = json["default_profile_image"].string
            profileBackgroundColor = json["profile_background_color"].string
            profileLocation = json["profile_location"].string
            profileBackgroundTile = json["profile_background_tile"].bool
            profileSidebarFillColor = json["profile_sidebar_fill_color"].string
            isTranslator = json["is_translator"].bool
            isTranslationEnabled = json["is_translation_enabled"].bool
            profileImageUrlHttps = json["profile_image_url_https"].string
            friendsCount = json["friends_count"].integer
            profileBackgroundImageUrlHttps = json["profile_background_image_url_https"].string
            utcOffset = json["utc_offset"].string
            profileImageUrl = json["profile_image_url"].string
            statusesCount = json["statuses_count"].integer
            defaultProfile = json["default_profile"].bool
            following = json["following"].bool
            url = json["url"].string
            name = json["name"].string
            geoEnabled = json["geo_enabled"].bool
            profileUseBackgroundImage = json["profile_use_background_image"].bool
            screenName = json["screen_name"].string
            descriptionStr = json["description"].string
            notifications = json["notifications"].bool
            contributorsEnabled = json["contributors_enabled"].bool
            hasExtendedProfile = json["has_extended_profile"].bool
            followersCount = json["followers_count"].integer
            location = json["location"].string
            verified = json["verified"].bool
            createdAt = json["created_at"].string
            followRequestSent = json["follow_request_sent"].bool
            idStr = json["id_str"].string
            profileBannerUrl = json["profile_banner_url"].string
            profileBackgroundImageUrl = json["profile_background_image_url"].bool
            profivarextColor = json["profile_text_color"].string
            translatorType = json["translator_type"].string
        }
    }
    
    // Tweet
    class Tweet: NSObject {
        var id:Int?
        var idStr:String?
        var inReplyToStatusIdStr:String?
        var isQuoteStatus:Bool?
        var source:String?
        var lang:String?
        //    var place
        var retweetCount:Int?
        var favorited:Bool?
        var inReplyToScreenName:String? // リプライ先のユーザーネーム
        var displayTextRange:[Double]?
        var retweeted:Bool?
        //    var geo:
        var inReplyToUserId:Int?
        //    var metadata:
        var user:User?
        var favoriteCount:Int?
        //    var coordinates:
        var possiblySensitive:Bool?
        var createdAt:String?
        //    var contributors:
        var inReplyToUserIdStr:String?
        var truncated:Bool?
        var fullText:String?
        var extendedEntities:Entities?
        var entities:Entities?
        
        init(json:JSON) {
//            print("\n\n\n\n\n\n\n\n\n\n\n\n")
//            print(json)
            inReplyToStatusIdStr    = json["in_reply_to_status_id_str"].string
            isQuoteStatus           = json["is_quote_status"].bool
            source                  = json["source"].string
            lang                    = json["lang"].string
            //    place
            retweetCount            = json["retweet_count"].integer
            favorited               = json["favorited"].bool
            inReplyToScreenName     = json["in_reply_to_screen_name"].string
            id                      = json["id"].integer
            idStr                   = json["id_str"].string
            //        displayTextRange        = json["display_text_range"].array
            retweeted               = json["retweeted"].bool
            //    geo:
            inReplyToUserId         = json["in_reply_to_user_id"].integer
            //    metadata:
            user                    = User.init(json:json["user"])
            favoriteCount           = json["favorite_count"].integer
            //    coordinates:
            possiblySensitive       = json["possibly_sensitive"].bool
            createdAt               = json["created_at"].string
            
            truncated               = json["truncated"].bool
            fullText                = json["full_text"].string
            if (json["extended_entities"] == nil || json["extended_entities"].description.isEmpty) {
                print("empty ex tended")
            }
            if (json["entities"] == nil || json["entities"].description.isEmpty) {
                print("empty en tities")
            }
            extendedEntities        = Entities.init(json: json["extended_entities"])
            entities                = Entities.init(json: json["entities"])
        }
        
        func url() -> String? {
            if let screenName = user?.screenName {
                return "https://twitter.com/" + screenName + "/status/" + self.idStr!
            }
            else {
                return nil
            }
        }
    }
    
    // ExtendedEntity
    class Entities: NSObject {
        var medias:[Media]?
        var indices:[Double]?
        var url:String?
        
        init(json:JSON) {
            if (json == nil || json.description.isEmpty) {
                print("からだ")
            }
            if let array = json["media"].array {
                medias = Media.initArray(jsons: array)
            }
            //        indices <- json["indices"].double
            url     = json["url"].string
        }
    }
    
    // Media
    // https://docs.google.com/spreadsheets/d/1dK8cK8M_XDN0RjguwBggo-FPgKDwoHUWRqoBzQN_AKU/edit#gid=0
    class Media: NSObject {
        
        var idStr:String?
        var mediaUrlHttps:String?
        var mediaUrl:String?
        var expandedUrl:String?   //tweetのurl
        var displayUrl:String?
        var type:String?
        var indices:JSON
        var sizes:JSON  //そのまま保持
        
        init(json:JSON) {
            idStr               = json["id_str"].string
            mediaUrlHttps       = json["media_url_https"].string
            mediaUrl            = json["media_url"].string
            expandedUrl         = json["expanded_url"].string
            displayUrl          = json["display_url"].string
            type                = json["type"].string
            // 仕様わからん
            print("type : " + type!)
            indices             = json["indices"]
            sizes               = json["sizes"]
        }
        
        static func initArray(jsons:[JSON]) -> [Media] {
            var medias:[Media] = []
            for j in jsons {
                medias.append(Media.init(json: j))
            }
            return medias
        }

    }
    
    class Hashtag: NSObject {
        var text:String?
        var indices:JSON?
        
        init(json:JSON) {
            text = json["text"].string
            indices = json["indices"]
        }
    }
    
    class Url: NSObject {
        var url:String?
        var expandedUrl:String?
        var displayUrl:String?
        var unwound:Unwound?
        var indices:JSON?
        
        init(json:JSON) {
            url = json["url"].string
            expandedUrl = json["expandedUrl"].string
            displayUrl = json["displayUrl"].string
            unwound = Unwound.init(json: json["unwound"])
            indices = json["indices"]
        }
    }
    
    class Unwound: NSObject {
        var url:String?
        var status:Int?
        var title:String?
        var descriptionStr:String?
        var indices:JSON?
        
        init(json:JSON) {
            url = json["url"].string
            status = json["status"].integer
            title = json["title"].string
            descriptionStr = json["description"].string
            indices = json["indices"]
        }
    }
    
    class UserMention: NSObject {
        var screenName:String?
        var name:String?
        var id:Int?
        var idStr:String?
        var indices:JSON?
        
        init(json:JSON) {
            screenName = json["screen_name"].string
            name = json["name"].string
            id = json["id"].integer
            idStr = json["id_str"].string
            indices = json["indices"]
        }
    }
    
    class Symbol: NSObject {
        var text:String?
        var indices:JSON?
        
        init(json:JSON) {
            text = json["text"].string
            indices = json["indices"]
        }
    }
    
    
}

























// ObjectMapper使おうとしたけど、Swifterのjsonが独自のものでダメだったーの一応保持

/*
 
 // 参考になりそう:http://syossan.hateblo.jp/entry/20110219/1298099350
 class TwitterUser: Mappable {
 var timeZone:String?
 var protected:Bool?
 var profileSidebarBorderColor:String?   //サイドバーボーダーカラー
 var profileLinkColor:String?            //プロフィールリンクカラー
 var lang:String?                         //言語
 var favouritesCount:Int?              //ふぁぼった数
 var defaultProfileImage:String?     //?
 var profileBackgroundColor:String?  // 背景
 var profileLocation:String?
 var profileBackgroundTile:Bool?  //画像をタイル状にするか
 var profileSidebarFillColor:String? //ユーザマイページサイドバーの背景色
 var isTranslator:Bool?               //Interested in helping translate Twitter? Check out the Translation Center.」のリンク
 var isTranslationEnabled:Bool?
 var profileImageUrlHttps:String?
 var friendsCount:Int?       // フォロー数
 var profileBackgroundImageUrlHttps:String?
 var utcOffset:String?        //ユーザが設定しているタイムゾーンとUTC（協定世界時）との差
 var profileImageUrl:String?      // http
 var statusesCount:Int?              //ツイート数
 var defaultProfile:Bool?     //?
 var following:Bool?          // フォローしているかどうか　連携してないからnullだ
 var url:String?              // web url
 var name:String?             // ユーザー名
 var geoEnabled:Bool?         // ツイートに位置情報をつけるか
 var profileUseBackgroundImage:Bool?      // 背景画像を用いるかどうか
 var screenName:String?                   // ユーザー名
 var description:String?                  // 説明
 var notifications:Bool?                  // 指定ユーザからの通知メールを受け取るかどうか
 var contributorsEnabled:Bool?            // Twitterのライター機能を使用しているかどうか
 var hasExtendedProfile:Bool?         // ?
 var followersCount:Int?             // フォロワーの数
 var location:String?                 //ロケーション文字列
 var verified:Bool?                   // 認証済みアカウントかどうか
 var createdAt:String?
 var followRequestSent:Bool?          // 鍵付きユーザに対し、フォロー申請したかどうか
 var id:Int?
 var idStr:String?
 var profileBannerUrl:String?
 var profileBackgroundImageUrl:Bool?
 var profivarextColor:String?
 var translatorType:String?           // ?
 
 /*
 init(json:JSON) {
 
 timeZone = json["time_zone"].string
 protected = json["protected"].bool
 profileSidebarBorderColor = json["profile_sidebar_border_color"].string
 profileLinkColor = json["profile_link_color"].string
 lang = json["lang"].string
 favouritesCount = json["favorites_count"].integer
 defaultProfileImage = json["default_profile_image"].string
 profileBackgroundColor = json["profile_background_color"].string
 profileLocation = json["profile_location"].string
 profileBackgroundTile = json["profile_background_tile"].bool
 profileSidebarFillColor = json["profile_sidebar_fill_color"].string
 isTranslator = json["is_translator"].bool
 isTranslationEnabled = json["is_translation_enabled"].bool
 profileImageUrlHttps = json["profile_image_url_https"].string
 friendsCount = json["friends_count"].integer
 profileBackgroundImageUrlHttps = json["profile_background_image_url_https"].string
 utcOffset = json["utc_offset"].string
 profileImageUrl = json["profile_image_url"].string
 statusesCount = json["statuses_count"].integer
 defaultProfile = json["default_profile"].bool
 following = json["following"].bool
 url = json["url"].string
 name = json["name"].string
 geoEnabled = json["geo_enabled"].bool
 profileUseBackgroundImage = json["profile_use_background_image"].bool
 screenName = json["screen_name"].string
 description = json["description"].string
 notifications = json["notifications"].bool
 contributorsEnabled = json["contributors_enabled"].bool
 hasExtendedProfile = json["has_extended_profile"].bool
 followersCount = json["followers_count"].integer
 location = json["location"].string
 verified = json["verified"].bool
 createdAt = json["created_at"].string
 followRequestSent = json["follow_request_sent"].bool
 id_str = json["id_str"].string
 profileBannerUrl = json["profile_banner_url"].string
 profileBackgroundImageUrl = json["profile_background_image_url"].bool
 profivarextColor = json["profile_text_color"].string
 translatorType = json["translator_type"].string
 }*/
 
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 timeZone                    <- map["time_zone"]//:String?
 protected                   <- map["protected"]//:Bool?
 profileSidebarBorderColor   <- map["profile_sidebar_border_color"]//:String?   //サイドバーボーダーカラー
 profileLinkColor            <- map["profile_link_color"]//:String?            //プロフィールリンクカラー
 lang                        <- map["lang"]//:String?                         //言語
 favouritesCount             <- map["favourites_count"]//:Int?              //ふぁぼった数
 defaultProfileImage         <- map["default_profile_image"]//:String?     //?
 profileBackgroundColor      <- map["profile_background_color"]//:String?  // 背景
 profileLocation             <- map["profile_location"]//:String?
 profileBackgroundTile       <- map["profile_background_title"]//:Bool?  //画像をタイル状にするか
 profileSidebarFillColor     <- map["profile_sidebar_fill_color"]//:String? //ユーザマイページサイドバーの背景色
 isTranslator                <- map["in_translator"]//:Bool?               //Interested in helping translate Twitter? Check out the Translation Center.」のリンク
 isTranslationEnabled        <- map["is_translation_enabled"]//:Bool?
 profileImageUrlHttps        <- map["profile_image_url_https"]//:String?
 friendsCount                <- map["friends_count"]//:Int?       // フォロー数
 profileBackgroundImageUrlHttps <- map["profile_background_image_url_https"]//:String?
 utcOffset                   <- map["utc_offset"]//:String?        //ユーザが設定しているタイムゾーンとUTC（協定世界時）との差
 profileImageUrl             <- map["profile_image_url"]//:String?      // http
 statusesCount               <- map["statuses_count"]//:Int?              //ツイート数
 defaultProfile              <- map["default_profile"]//:Bool?     //?
 following                   <- map["following"]//:Bool?          // フォローしているかどうか　連携してないからnullだ
 url                         <- map["url"]//:String?              // web url
 name                        <- map["name"]//:String?             // ユーザー名
 geoEnabled                  <- map["geo_enabled"]//:Bool?         // ツイートに位置情報をつけるか
 profileUseBackgroundImage   <- map["profile_use_background_image"]//:Bool?      // 背景画像を用いるかどうか
 screenName                  <- map["screen_name"]//:String?                   // ユーザー名
 description                 <- map["description"]//:String?                  // 説明
 notifications               <- map["notifications"]//:Bool?                  // 指定ユーザからの通知メールを受け取るかどうか
 contributorsEnabled         <- map["contributors_enabled"]//:Bool?            // Twitterのライター機能を使用しているかどうか
 hasExtendedProfile          <- map["has_extended_profile"]//:Bool?         // ?
 followersCount              <- map["followers_count"]//:Int?             // フォロワーの数
 location                    <- map["location"]//:String?                 //ロケーション文字列
 verified                    <- map["verified"]//:Bool?                   // 認証済みアカウントかどうか
 createdAt                   <- map["created_at"]//:String?
 followRequestSent           <- map["follow_request_sent"]//:Bool?          // 鍵付きユーザに対し、フォロー申請したかどうか
 id                          <- map["id"]
 idStr                       <- map["id_str"]//:String?
 profileBannerUrl            <- map["profile_banner_url"]//:String?
 profileBackgroundImageUrl   <- map["profile_background_image_url"]//:Bool?
 profivarextColor            <- map["profile_text_color"]//:String?
 translatorType              <- map["translator_type"]//:String?           // ?
 }
 }
 
 // Tweet
 class TwitterTweet: Mappable {
 var id:Int?
 var inReplyToStatusIdStr:String?
 var isQuoteStatus:Bool?
 var source:String?
 var lang:String?
 //    var place
 var retweetCount:Int?
 var favorited:Bool?
 var inReplyToScreenName:String? // リプライ先のユーザーネーム
 var displayTextRange:[Double]?
 var retweeted:Bool?
 //    var geo:
 var inReplyToUserId:Int?
 //    var metadata:
 var user:TwitterUser?
 var favoriteCount:Int?
 //    var coordinates:
 var possiblySensitive:Bool?
 var createdAt:Date?
 
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 inReplyToStatusIdStr    <- map["in_reply_to_status_id_str"]// :String?
 isQuoteStatus           <- map["is_quote_status"]//:Bool?
 source                  <- map["source"]//:String?
 lang                    <- map["lang"]//:String?
 //    place
 retweetCount            <- map["retweet_count"]//:Int?
 favorited               <- map["favorited"]//:Bool?
 inReplyToScreenName     <- map["in_reply_to_screen_name"]//:String? // リプライ先のユーザーネーム
 id                      <- map["id"]//:Int?
 displayTextRange        <- map["display_text_range"]//:[Double]?
 retweeted               <- map["retweeted"]//:Bool?
 //    geo:
 inReplyToUserId         <- map["in_reply_to_user_id"]//:Int?
 //    metadata:
 user                    <- map["user"]//:TwitterUser?
 favoriteCount           <- map["favorite_count"]//:Int?
 //    coordinates:
 possiblySensitive       <- map["possibly_sensitive"]//:Bool?
 createdAt               <- map["created_at"]//:Date?
 }
 
 }
 
 // ExtendedEntity
 class TwitterExtendedEntity: Mappable {
 var media:TwitterMedia?
 var indices:[Double]?
 var url:String?
 
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 media   <- map["media"]
 indices <- map["indices"]
 url     <- map["url"]
 }
 }
 
 // Media
 // https://docs.google.com/spreadsheets/d/1dK8cK8M_XDN0RjguwBggo-FPgKDwoHUWRqoBzQN_AKU/edit#gid=0
 class TwitterMedia: Mappable {
 
 var idStr:String?
 var mediaUrlHttps:String?
 var mediaUrl:String?
 var expandedUrl:String?   //tweetのurl
 var displayUrl:String?
 var type:String?
 var indices:[Double]?
 var sizes:TwitterMediaSize?
 
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 idStr               <- map["id_str"]
 mediaUrlHttps       <- map["media_url_https"]
 mediaUrl            <- map["media_url"]
 expandedUrl         <- map["expanded_url"]
 displayUrl          <- map["display_url"]
 type                <- map["type"]
 indices             <- map["indices"]
 sizes               <- map["sizes"]
 }
 }
 
 class TwitterMediaSize: Mappable {
 
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 }
 }
 
 class TwitterEntity: Mappable {
 // user内　後回し
 required init?(map: Map) {
 }
 
 func mapping(map: Map) {
 }
 
 }
 
 
 
 //"id" : 8.70547677364101e+17,
 //"entities" : {
 //    "description" : {
 //        "urls" : [
 //
 //        ]
 //    },
 //    "url" : {
 //        "urls" : [
 //        {
 //        "display_url" : "yurucamp.jp",
 //        "indices" : [
 //        0.0,
 //        23.0
 //        ],
 //        "expanded_url" : "http://yurucamp.jp/",
 //        "url" : "https://t.co/t6yUrc16cG"
 //        }
 //        ]
 //    }
 //},
 
 
 // 固定化されたツイートかな？
 //"status" : {
 //    "created_at" : "Tue Jan 30 03:06:29 +0000 2018",
 //    "in_reply_to_status_id" : null,
 //    "is_quote_status" : false,
 //    "source" : "<a href=\"http://twitter.com\" rel=\"nofollow\">Twitter Web Client</a>",
 //    "in_reply_to_status_id_str" : null,
 //    "lang" : "ja",
 //    "place" : null,
 //    "favorite_count" : 558.0,
 //    "coordinates" : null,
 //    "retweet_count" : 294.0,
 //    "favorited" : false,
 //    "in_reply_to_screen_name" : null,
 //    "id" : 9.58174548536435e+17,
 //    "retweeted" : false,
 //    "possibly_sensitive" : false,
 //    "text" : "【第5話あらすじを公開】\nTVアニメ「ゆるキャン△」第5話「二つのキャンプ、二人の景色」のあらすじが公開されております！\n是非チェックしてみてくださいね♪\nhttps://t.co/8iWnSjS52a\n#ゆるキャン https://t.co/ZMm9P0Ahnz",
 //    "in_reply_to_user_id_str" : null,
 //    "id_str" : "958174548536434690",
 //    "contributors" : null,
 //    "entities" : {
 //        "urls" : [
 //        {
 //        "display_url" : "yurucamp.jp/story/episode0…",
 //        "indices" : [
 //        78.0,
 //        101.0
 //        ],
 //        "expanded_url" : "http://yurucamp.jp/story/episode05.php",
 //        "url" : "https://t.co/8iWnSjS52a"
 //        }
 //        ],
 //        "user_mentions" : [
 //
 //        ],
 //        "media" : [
 //        {
 //        "media_url_https" : "https://pbs.twimg.com/media/DUwepNtVwAAfmfB.jpg",
 //        "id" : 9.58174514126373e+17,
 //        "expanded_url" : "https://twitter.com/yurucamp_anime/status/958174548536434690/photo/1",
 //        "media_url" : "http://pbs.twimg.com/media/DUwepNtVwAAfmfB.jpg",
 //        "id_str" : "958174514126372864",
 //        "display_url" : "pic.twitter.com/ZMm9P0Ahnz",
 //        "type" : "photo",
 //        "sizes" : {
 //        "medium" : {
 //        "resize" : "fit",
 //        "h" : 675.0,
 //        "w" : 1200.0
 //        },
 //        "small" : {
 //        "resize" : "fit",
 //        "h" : 383.0,
 //        "w" : 680.0
 //        },
 //        "thumb" : {
 //        "resize" : "crop",
 //        "h" : 150.0,
 //        "w" : 150.0
 //        },
 //        "large" : {
 //        "resize" : "fit",
 //        "h" : 1080.0,
 //        "w" : 1920.0
 //        }
 //        },
 //        "indices" : [
 //        109.0,
 //        132.0
 //        ],
 //        "url" : "https://t.co/ZMm9P0Ahnz"
 //        }
 //        ],
 //        "symbols" : [
 //
 //        ],
 //        "hashtags" : [
 //        {
 //        "indices" : [
 //        102.0,
 //        108.0
 //        ],
 //        "text" : "ゆるキャン"
 //        }
 //        ]
 //    },
 //    "truncated" : false,
 //    "geo" : null,
 //    "in_reply_to_user_id" : null,
 //    "extended_entities" : {
 //        "media" : [
 //        {
 //        "media_url_https" : "https://pbs.twimg.com/media/DUwepNtVwAAfmfB.jpg",
 //        "id" : 9.58174514126373e+17,
 //        "expanded_url" : "https://twitter.com/yurucamp_anime/status/958174548536434690/photo/1",
 //        "media_url" : "http://pbs.twimg.com/media/DUwepNtVwAAfmfB.jpg",
 //        "id_str" : "958174514126372864",
 //        "display_url" : "pic.twitter.com/ZMm9P0Ahnz",
 //        "type" : "photo",
 //        "sizes" : {
 //        "medium" : {
 //        "resize" : "fit",
 //        "h" : 675.0,
 //        "w" : 1200.0
 //        },
 //        "small" : {
 //        "resize" : "fit",
 //        "h" : 383.0,
 //        "w" : 680.0
 //        },
 //        "thumb" : {
 //        "resize" : "crop",
 //        "h" : 150.0,
 //        "w" : 150.0
 //        },
 //        "large" : {
 //        "resize" : "fit",
 //        "h" : 1080.0,
 //        "w" : 1920.0
 //        }
 //        },
 //        "indices" : [
 //        109.0,
 //        132.0
 //        ],
 //        "url" : "https://t.co/ZMm9P0Ahnz"
 //        }
 //        ]
 //    }
 //},
 */
