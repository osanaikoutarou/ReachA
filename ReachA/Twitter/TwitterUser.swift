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
    var twitterUserRaw:TwitterUserRaw?
    
    // 要素
    var name:String?                     // なまえ
    var profileImageUrlHttps:String?     // アイコン

    func setup(json:JSON) {
        twitterUserRaw = TwitterUserRaw(json: json)
        
        if let twitterUserRaw = twitterUserRaw {
            name = twitterUserRaw.name
            profileImageUrlHttps = twitterUserRaw.profileImageUrlHttps!.replacingOccurrences(of:"_normal.jpg", with:".jpg")
            
            print(twitterUserRaw)
        }
    }
    
}

// 参考になりそう:http://syossan.hateblo.jp/entry/20110219/1298099350
class TwitterUserRaw {
    let timeZone:String?
    let protected:Bool?
    let profileSidebarBorderColor:String?   //サイドバーボーダーカラー
    let profileLinkColor:String?            //プロフィールリンクカラー
    let lang:String?                         //言語
    let favouritesCount:Int?              //ふぁぼった数
    let defaultProfileImage:String?     //?
    let profileBackgroundColor:String?  // 背景
    let profileLocation:String?
    let profileBackgroundTile:Bool?  //画像をタイル状にするか
    let profileSidebarFillColor:String? //ユーザマイページサイドバーの背景色
    let isTranslator:Bool?               //Interested in helping translate Twitter? Check out the Translation Center.」のリンク
    let isTranslationEnabled:Bool?
    let profileImageUrlHttps:String?
    let friendsCount:Int?       // フォロー数
//    let id:String           //TweetのID
    // https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/entities-object
    // エンティティは、Twitterに投稿されたコンテンツに関するメタデータと追加コンテキスト情報を提供します
    // entitiesセクションでは、ハッシュタグ、ユーザのコメント、リンク、株式ティッカー（シンボル）、Twitterの投票、添付されたメディアなど、ツイートに含まれる一般的なものの配列を提供します。 これらの配列は、Twitterが基本的に事前処理されているか、または事前に解析されているため、Tweetsを取り込むときに開発者にとって便利です。 Tweet本体でこれらのエンティティを明示的に検索して見つけ出す必要はなく、パーサーはこのJSONセクションに直接行くことができます。
//    let entities:[String]       //
    
    let profileBackgroundImageUrlHttps:String?
    let utcOffset:String?        //ユーザが設定しているタイムゾーンとUTC（協定世界時）との差
    let profileImageUrl:String?      // http
    let statusesCount:Int?              //ツイート数
    let defaultProfile:Bool?     //?
    let following:Bool?          // フォローしているかどうか　連携してないからnullだ
    let url:String?              // web url
    let name:String?             // ユーザー名
    let geoEnabled:Bool?         // ツイートに位置情報をつけるか
    let profileUseBackgroundImage:Bool?      // 背景画像を用いるかどうか
    let screenName:String?                   // ユーザー名
    let description:String?                  // 説明
    let notifications:Bool?                  // 指定ユーザからの通知メールを受け取るかどうか
    let contributorsEnabled:Bool?            // Twitterのライター機能を使用しているかどうか
    let hasExtendedProfile:Bool?         // ?
    let followersCount:Int?             // フォロワーの数
    let location:String?                 //ロケーション文字列
    let verified:Bool?                   // 認証済みアカウントかどうか
    let createdAt:String?
    let followRequestSent:Bool?          // 鍵付きユーザに対し、フォロー申請したかどうか
    let id_str:String?
    let profileBannerUrl:String?
    let profileBackgroundImageUrl:Bool?
    let profileTextColor:String?
    let translatorType:String?           // ?
    
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
        profileTextColor = json["profile_text_color"].string
        translatorType = json["translator_type"].string
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
