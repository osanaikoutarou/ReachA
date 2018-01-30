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


//"url" : "https://t.co/t6yUrc16cG",
//"listed_count" : 724.0,
//"name" : "TVアニメ「ゆるキャン△」公式",
//"geo_enabled" : false,
//"profile_use_background_image" : true,
//"screen_name" : "yurucamp_anime",
//"description" : "2018年1月4日より放送開始！TVアニメ「ゆるキャン△」の公式アカウントです。 原作コミック1巻～5巻好評発売中！最新巻の6巻は3月12日発売予定！ 毎月24日発売の「まんがタイムきららフォワード」（芳文社刊）にて大人気連載中 ©あｆろ・芳文社／野外活動サークル",
//"notifications" : null,
//"contributors_enabled" : false,
//"has_extended_profile" : false,
//"followers_count" : 36408.0,
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
//"location" : "富士山のふもと",
//"verified" : false,
//"created_at" : "Fri Jun 02 07:48:35 +0000 2017",
//"follow_request_sent" : null,
//"id_str" : "870547677364101120",
//"profile_banner_url" : "https://pbs.twimg.com/profile_banners/870547677364101120/1513174003",
//"profile_background_image_url" : null,
//"profile_text_color" : "333333",
//"translator_type" : "none"

// 参考になりそう:http://syossan.hateblo.jp/entry/20110219/1298099350
class TwitterUserDefinition {
    let timeZone:Date
    let protected:Bool
    let profileSidebarBorderColor:UIColor   //サイドバーボーダーカラー
    let profileLinkColor:UIColor            //プロフィールリンクカラー
    let lang:String                         //言語
    let favouritesCount:String              //ふぁぼった数
    let defaultProfileImage:String     //?
    let profileBackgroundColor:UIColor  // 背景
    let profileLocation:Locale
    let profileBackgroundTile:Bool  //画像をタイル状にするか
    let profileSidebarFillColor:UIColor //ユーザマイページサイドバーの背景色
    let isTranslator:Bool //Interested in helping translate Twitter? Check out the Translation Center.」のリンク
    let isTranslationEnabled:Bool
    let profileImageUrlHttps:String
    let friendsCount:NSInteger      // フォロー数
    let id:String           //TweetのID
    // https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/entities-object
    // エンティティは、Twitterに投稿されたコンテンツに関するメタデータと追加コンテキスト情報を提供します
    // entitiesセクションでは、ハッシュタグ、ユーザのコメント、リンク、株式ティッカー（シンボル）、Twitterの投票、添付されたメディアなど、ツイートに含まれる一般的なものの配列を提供します。 これらの配列は、Twitterが基本的に事前処理されているか、または事前に解析されているため、Tweetsを取り込むときに開発者にとって便利です。 Tweet本体でこれらのエンティティを明示的に検索して見つけ出す必要はなく、パーサーはこのJSONセクションに直接行くことができます。
    let entities:[String]       // これなんだろう？ Array Entityとは
    
    let profileBackgroundImageUrlHttps:String
    let utcOffset:String        //ユーザが設定しているタイムゾーンとUTC（協定世界時）との差
    let profileImageUrl:String      // http
    let statusesCount:NSInteger              //ツイート数
    let defaultProfile:Bool     //?
    let following:Bool          // フォローしているかどうか　連携してないからnullだ
    
    
    
    
    init() {
    }
}
